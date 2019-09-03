class CreateAccountTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :account_transactions do |t|
      t.integer :transaction_id
      t.string :title
      t.decimal :amount, precision: 10, scale: 2
      t.decimal :initial_balance, precision: 10, scale: 2
      t.decimal :closing_balance, precision: 10, scale: 2
      t.references :account_transaction_type, foreign_key: true
      t.references :account, foreign_key: true
      t.references :account_transaction_status, foreign_key: true
      t.text :note
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
