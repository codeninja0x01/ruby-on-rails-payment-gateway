class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :birth_date

      t.timestamps
    end
  end
end
