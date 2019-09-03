class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :remember_digest  
      t.string :activation_digest  
      t.boolean :activated, default: false
      t.datetime :activated_at 
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.references :account, foreign_key: true
      t.references :user_info, foreign_key: true
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end