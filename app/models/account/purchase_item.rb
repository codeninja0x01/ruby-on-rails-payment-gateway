class Account::PurchaseItem < ApplicationRecord
  belongs_to :account
  belongs_to :business, class_name: :Account

  def make_payment
	self.account.transact_fund(self.item_price, self.business)
  end

end
