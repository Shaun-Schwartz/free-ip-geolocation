class CreateApiKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :api_keys, id: :uuid do |t|
      t.string :key
      t.boolean :active
      t.belongs_to :users, type: :uuid
    end
    add_index :api_keys, :key, unique: true
  end
end
