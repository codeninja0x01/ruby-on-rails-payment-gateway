class CreateAccountTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_types do |t|
      t.string :name
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end
  end
end
