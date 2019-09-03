class BalanceCard::History < ApplicationRecord
  belongs_to :balance_card
  belongs_to :account
end
