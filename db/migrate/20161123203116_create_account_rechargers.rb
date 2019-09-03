class CreateAccountRechargers < ActiveRecord::Migration[5.0]
  def change
    create_table :account_rechargers do |t|
      t.integer :serial_number
      t.decimal :card_number, precision: 16
      t.integer :amount
      t.datetime :expiration_date
      t.datetime :created_at
      t.integer :created_by
    end
  end
end
