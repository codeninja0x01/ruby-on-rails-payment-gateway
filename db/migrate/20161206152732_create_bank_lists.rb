class CreateBankLists < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_lists do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.boolean :is_international
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end
  end
end
