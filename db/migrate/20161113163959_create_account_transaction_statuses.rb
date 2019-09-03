class CreateAccountTransactionStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :account_transaction_statuses do |t|
      t.string :title

      t.timestamps
    end
  end
end
