class AddRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :request
      t.references :user, type: :uuid, index: true, null: false
      t.timestamps
    end
  end
end
