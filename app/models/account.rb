class Account < ApplicationRecord

	attr_accessor :receiver
	attr_accessor :amount

    # Associations
 	belongs_to :type, class_name: 'Account::Type', foreign_key: 'account_type_id'
	
	# account holder user
	# relationship one-one
	has_one :user

	# activity of an account
	# relationship one-many
	has_many :transactions

	# associated bank account
	# relationship one-many
	has_many :banks

	has_many :purchase_items

  	# Validation
	validates :account_id, presence: true, numericality: { only_integer: true }

	# validates :amount, :receiver, presence: true, on: :transfer_fund

	# Callback Registration
	before_validation :generate_account_id, on: :create

	validate :check_if_reciver_is_not_account_holder, on: :transfer_fund

	validate :check_if_account_holder_has_sufficient_balance, on: :transfer_fund

	validate :check_receiver_and_amount, on: :transfer_fund

	# validates_associated :bank

	# Class Method
	def deposite(amount, type, from, status)
		# add desposite amount to current_balance
		t_initial_balance = self.current_balance

		# get the transaction_type
		t_type = transaction_type(type)
		t_status = transaction_status(status)

		if status == 'completed'
			total = t_initial_balance + amount

			self.update(initial_balance: total, current_balance: total)
		end

		# create a account_transactions
        self.transactions.create(
        		   title: from,
        		   amount: amount,
                   initial_balance: t_initial_balance,
                   closing_balance: total,
                   transaction_type: t_type,
                   # note: note unless note.nil?,
                   status: t_status
                   )
		return total;
	end

	def credit(amount, type, to, note = nil, status)

		t_total_balance = self.current_balance

		# get the transaction_type
		t_type = transaction_type(type)
		t_status = transaction_status(status)

		# check if the account has enough balance
		if t_total_balance > amount
			
			if status == 'completed'
				# check if the total amount to be credit is less than current_balance 
				total = t_total_balance - amount

				# update initial_balance and current_balance to the credit amount
				self.update(current_balance: total)
			end

			# create a account_transactions
			self.transactions.create(
								title: to,
								amount: amount,
								initial_balance: t_total_balance,
								closing_balance: total,
								transaction_type: t_type,
								note: note,
								status: t_status
								)
			return true 		
		end

		self.valid?(:credit)
		return false
	end

	def transact_fund(amount, receiver, note = nil)
		if check_account(receiver)
	      # credit from the account and check if its success
	      if(self.credit(amount, 'payment_to', receiver.user.info.full_name, note, 'completed'))
	        
	        # check if the receiver is merchant account and minus the service fee
	        if receiver.type == Account::Type.find_by_name('Bussiness')
	            fee = (amount / 100.00) * 5
	            total = amount-fee
	            amount = total
	        end	

	        #TODO then save the service fee to system

	        # deposite to the receiver
	        receiver.deposite(amount, 'payment_from', self.user.info.full_name, 'completed')
	      end
	    end
  	end

  	def refund

  	end

  	def transfer_fund(amount, receiver, note = nil)
  		self.receiver = receiver
		self.amount = amount
  		
  		if check_account(receiver) && amount > 0
      		if(self.credit(amount, 'transfer_to', receiver.user.info.full_name, note, 'completed'))
  				# deposite to the receiver
        		receiver.deposite(amount, 'transfer_from', self.user.info.full_name, 'completed')
  			end
  		end
  	end

  	def check_receiver_and_amount
  		if self.amount.nil? || self.amount.zero?
	      errors.add(:amount, "can not be blank.")
  		elsif self.receiver.nil?
	      errors.add(:receiver, "can not be blank.")
  		end
  	end

  	def check_if_reciver_is_not_account_holder
  		if self.account_id == receiver.account_id
	      errors.add(:receiver, "you cannot transfer to your own Account.")
  		end
  	end

  	def check_if_account_holder_has_sufficient_balance
  		if self.current_balance < self.amount
	      errors.add(:receiver, "you dont have sufficient balance")
  		end
  	end

	def check_account(account)
	    # get the receiver account
	    return true unless account == self
	end

	def verify_bank
		
	end

	protected
	# Method Callback
	def generate_account_id
		self.account_id = Account.any? ? Account.last.account_id + 5 : 1000000			
	end

	def transaction_type(type)
		# check type of the account_transactions
		case type
		
		when 'payment_to'
			Account::TransactionType.find_by(title: 'Payment To')		
		when 'refund'
			Account::TransactionType.find_by(title: 'Re-Fund')
		when 'payment_from'		
			Account::TransactionType.find_by(title: 'Payment From')	
		when 'transfer_from'		
			Account::TransactionType.find_by(title: 'Transfered From')	
		when 'transfer_to'		
			Account::TransactionType.find_by(title: 'Transfered To')									
		when 'funded_from'
			Account::TransactionType.find_by(title: 'Funded From')
		end
	end

	def transaction_status(status)
		case status
		
		when 'pendding'
			Account::TransactionStatus.find_by(title: 'Pendding')		
		when 'completed'
			Account::TransactionStatus.find_by(title: 'Completed')
		when 'canceled'
			Account::TransactionStatus.find_by(title: 'Canceled')			
		end
	end

end
