class Account::TransferHistory < ApplicationRecord
  belongs_to :account
  belongs_to :receiver, class_name: :Account
end
