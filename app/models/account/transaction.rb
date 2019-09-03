class Account::Transaction < ApplicationRecord
  # Associations
  belongs_to :transaction_type, class_name: 'Account::TransactionType', foreign_key: "account_transaction_type_id"
  belongs_to :status, class_name: 'Account::TransactionStatus', foreign_key: "account_transaction_status_id"
  belongs_to :account

  # Validation
  validates :amount, presence: true

  scope :recent_transaction, lambda { order("account_transactions.created_at DESC")}
 	
end
