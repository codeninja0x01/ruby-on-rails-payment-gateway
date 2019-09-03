class Account::Recharger < ApplicationRecord

	validates :card_number, presence: true, 
							length: { is: 16 },
							numericality: { only_integer: true },
							uniqueness: true, on: :generate_card

	def self.generate_cards(x, amount)
		x.times do
			card_number = SecureRandom.random_number(1000000000000000)
			serial_number = Account::Recharger.any? ? Account::Recharger.last.serial_number + 100 : 1000000
			expiration_date = DateTime.now + 362
			amount = amount
			Account::Recharger.create(card_number: card_number, serial_number: serial_number, amount: amount, expiration_date: expiration_date)
		end
	end

	def self.generate_card(amount)
			card_number = SecureRandom.random_number(1000000000000000)
			serial_number = Account::Recharger.any? ? Account::Recharger.last.serial_number + 100 : 1000000
			expiration_date = DateTime.now + 362
			amount = amount
			r = Account::Recharger.create(card_number: card_number, serial_number: serial_number, amount: amount, expiration_date: expiration_date)
			r.card_number
	end

	def self.charge_card(card_number)
		if r = Account::Recharger.find_by(card_number: card_number)
			if r.expiration_date > DateTime.now
				amount = r.amount
				r.destroy
				amount.to_d
			end
		end
	end
end
