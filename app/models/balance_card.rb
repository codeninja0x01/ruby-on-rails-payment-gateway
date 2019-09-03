class BalanceCard < ApplicationRecord

	attr_accessor :amount

	# validates :card_code, presence: true, 
	# 					length: { is: 16 },
	# 					numericality: { only_integer: true }

	validate :check_expiration_date, :check_if_card_has_balance

	validates :amount, presence: true, on: :fund_account

	validate :check_if_current_balance_is_greater_than_amount, on: :fund_account

	has_many :histories

	def fund_account(amount, account)
		self.amount = amount

		if account
			
			current = self.current_balance
			t_amount = self.amount.to_d

			if t_amount <= current
				total = current - t_amount
				self.update(current_balance: total)
				self.histories.create(fund_amount: t_amount , fund_on: DateTime.now, account: account)
				account.deposite(t_amount, 'funded_from', 'Balance Card')
			end
		end
	end

	def check_expiration_date
	    if self.expired_at.present? && self.expired_at < Date.today
	      errors.add(:expiration_date, "This card has been expired.")
	    end
	end

	def check_if_card_has_balance
		if self.current_balance <= 0
	      errors.add(:balance_card, "This card balance is insufficient to fund.")
		end
	end

	def check_if_current_balance_is_greater_than_amount
		if self.amount.to_d > self.current_balance
			errors.add(:balance_card, "Please enter less amount of fund.")
		end
	end


end
