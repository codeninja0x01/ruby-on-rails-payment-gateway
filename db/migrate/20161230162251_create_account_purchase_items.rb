class CreateAccountPurchaseItems < ActiveRecord::Migration[5.0]
  def change
    create_table :account_purchase_items do |t|
      t.decimal :item_price, precision: 10, scale: 2
      t.string :item_name
      t.text :item_desc
      t.references :account, foreign_key: true
      t.references :business, foreign_key: {to_table: :accounts}
      t.boolean :is_completed

      t.timestamps
    end
  end
end
