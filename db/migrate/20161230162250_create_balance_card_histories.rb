class CreateBalanceCardHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :balance_card_histories do |t|
      t.decimal :fund_amount, precision: 10, scale: 2
      t.datetime :fund_on
      t.references :balance_card, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
