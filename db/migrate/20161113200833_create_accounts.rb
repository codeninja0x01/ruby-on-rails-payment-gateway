class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :account_id
      t.decimal :initial_balance, precision: 10, scale: 2
      t.decimal :current_balance, precision: 10, scale: 2
      t.date :close_date
      t.references :account_type, foreign_key: true

      t.timestamps
    end
  end
end
