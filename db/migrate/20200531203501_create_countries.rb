class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :abbreviation
      t.string :region, index: true
      t.string :city, index: true
      t.timestamps
    end
    add_index :countries, [:name, :abbreviation, :region, :city], unique: true
  end
end
