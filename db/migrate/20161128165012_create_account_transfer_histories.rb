class CreateAccountTransferHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :account_transfer_histories do |t|
      t.decimal :transfer_amount, precision: 10, scale: 2
      t.datetime :transfer_on
      t.references :receiver, foreign_key: {to_table: :accounts}
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
