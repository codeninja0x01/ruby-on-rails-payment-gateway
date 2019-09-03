class User < ApplicationRecord
  
  attr_accessor :remember_token, :activation_token, :reset_token

  # Associations
  belongs_to :info, class_name: 'User::Info', foreign_key: 'user_info_id'
  belongs_to :account

  has_many :traces

  # Authentication
  has_secure_password

  # Validation
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: EMAIL_REGEX, message: "invalid email address" },
                    presence: true
                    
  validates :terms_of_service, acceptance: true

  validates :password, length: {minimum: 8 }, allow_blank: true
 
  # Validation Association
  validates_associated :account
  validates_associated :info

  # Nested Attributes
  accepts_nested_attributes_for :account, reject_if: proc { |attributes| attributes['account_type_id'].blank? }
  accepts_nested_attributes_for :info, reject_if: proc { |attributes| attributes['first_name'].blank? &&  attributes['last_name'].blank?}

  before_save :downcase_email

  before_create :create_activation_digest

  def account
    super || build_account(initial_balance: 0.0,
                 current_balance: 0.0,
                 )
  end

  def info
    super || build_info
  end

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember_me
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget_me
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest) == token
  end

  # Activate an account.
  def activate
    self.update_attribute(:activated, true)
    self.update_attribute(:activated_at, Time.zone.now)
  end

  # Send activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
 
 # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #Return true if a password rest has expired
  def password_rest_expired?
    reset_sent_at < 2.hours.ago
  end

  private
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
  
  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
