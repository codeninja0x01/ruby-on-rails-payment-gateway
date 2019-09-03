class Account::Bank < ApplicationRecord
  belongs_to :bank_list
  belongs_to :account

  validates :bank_holder_name,  presence: true
  validates :bank_account_number, presence: true

  accepts_nested_attributes_for :bank_list

end
