class CreateUserTraces < ActiveRecord::Migration[5.0]
  def change
    create_table :user_traces do |t|
      t.datetime :sign_in_at
      t.string :sign_in_ip
      t.references :user, foreign_key: true
    end
  end
end
