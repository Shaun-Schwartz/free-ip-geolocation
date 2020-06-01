class CreateIpAddressRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_address_ranges do |t|
      t.references :country
      t.inet :start_address
      t.inet :end_address
      t.inet :mask
      t.integer :count
      t.timestamps
    end
  end
end
