class CreateIpAddressRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_address_ranges do |t|
      t.references :country
      t.inet :start_ip, index: true
      t.inet :end_ip, index: true
      t.integer :start_int, index: true
      t.integer :end_int, index: true
      t.integer :mask, index: true
      t.timestamps
    end
    add_index :ip_address_ranges, [:country_id, :start_ip, :end_ip, :start_int, :end_int],
      unique: true, name: 'index_ip_address_range_unique_for_upsert'
  end
end
