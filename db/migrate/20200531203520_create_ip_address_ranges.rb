class CreateIpAddressRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_address_ranges do |t|
      t.references :location, index: true
      t.string :start_ip
      t.string :end_ip
      t.integer :start_int, limit: 8, index: true
      t.integer :end_int, limit: 8, index: true
      t.integer :mask
      t.timestamps
    end
    add_index :ip_address_ranges, [:start_ip, :end_ip], unique: true
  end
end
