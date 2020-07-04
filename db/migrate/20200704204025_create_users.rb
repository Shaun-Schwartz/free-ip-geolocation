class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :password_digest
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.string :password_reset_token
      t.timestamps
    end
  end
end
