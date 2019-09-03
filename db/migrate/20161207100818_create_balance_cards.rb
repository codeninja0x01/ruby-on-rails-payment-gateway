class CreateBalanceCards < ActiveRecord::Migration[5.0]
  def change
    create_table :balance_cards do |t|
      t.string :card_code
      t.integer :serial_number
      t.decimal :initial_balance, precision: 10, scale: 2
      t.decimal :current_balance, precision: 10, scale: 2
      t.datetime :expired_at

      t.timestamps
    end
  end
end
