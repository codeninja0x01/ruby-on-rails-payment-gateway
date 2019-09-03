class User::Info < ApplicationRecord

	has_one :user

	validates :first_name, presence: true,
                         length: { :within => 2..50 } 

  	validates :last_name, presence: true,
                         length: { :within => 2..50 }

    def full_name
    	"#{self.first_name} #{self.last_name}".titleize
  	end
end
