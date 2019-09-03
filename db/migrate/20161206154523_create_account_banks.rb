class CreateAccountBanks < ActiveRecord::Migration[5.0]
  def change
    create_table :account_banks do |t|
      t.references :bank_list, foreign_key: true
      t.references :account, foreign_key: true
      t.string :bank_account_number
      t.string :bank_holder_name
      t.boolean :verified
      t.datetime :verified_at
      t.integer :verified_by

      t.timestamps
    end
  end
end
