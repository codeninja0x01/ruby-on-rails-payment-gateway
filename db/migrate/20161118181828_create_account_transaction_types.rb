class CreateAccountTransactionTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_transaction_types do |t|
      t.string :title

      t.timestamps
    end
  end
end
