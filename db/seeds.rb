# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
type = Account::Type.create([{name: 'Personal'}, {name: 'Bussiness'}])

c = Account.create([
							{
							initial_balance: 25.00, current_balance: 25.00, type: type.first
							},
							{
							initial_balance: 20.00, current_balance: 20.00, type: type.last
							}
						])
i = User::Info.create([{first_name: 'Robel', last_name: 'Meisho'}, {first_name: 'Samuel', last_name: 'Meisho'}])

user = User.create([
						{info: i.first, email: 'robel@gmail.com', password: '123456789', account: c.first,  activated: true}, 
						{info: i.last, email: 'samuel@gmail.com', password: '123456789', account: c.last, activated: true}
					])

transactionType = Account::TransactionType.create([{title: 'Payment To'}, {title: 'Payment From'}, {title: 'Funded From'}, {title: 'Re-Funded'}, {title: 'Transfered To'}, {title: 'Transfered From'}])
transactionStatus = Account::TransactionStatus.create([{title: 'Pending'}, {title: 'Completed'}, {title: 'Canceled'}])

# Account::FundType.create(title: 'Balance Card')
# Account::FundType.create(title: 'Bank')