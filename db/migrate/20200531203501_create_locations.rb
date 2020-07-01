class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :country, index: true
      t.string :abbreviation
      t.string :region
      t.string :city
      t.timestamps
    end
  end
end
