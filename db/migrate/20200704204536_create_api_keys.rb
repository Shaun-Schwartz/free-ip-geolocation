class CreateApiKeys < ActiveRecord::Migration[6.0]
  def up
    create_table :api_keys, id: :uuid do |t|
      t.string :token
      t.boolean :active, default: true
      t.uuid :user_id, index: true, null: false
      t.timestamps
    end
    add_index :api_keys, :token, unique: true
  end
end
