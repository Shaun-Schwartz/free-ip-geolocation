class CreateIpAddressRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_address_ranges do |t|
      t.references :country
      t.inet :start_ip, index: true
      t.inet :end_ip, index: true
      t.inet :mask, index: true
      t.integer :count, index: true
      t.timestamps
    end
    add_index :ip_address_ranges, [:country_id, :start_ip, :end_ip], unique: true
  end
end



# 79.133.0.0
# 79.133.31.255
