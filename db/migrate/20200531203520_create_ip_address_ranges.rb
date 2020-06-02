class CreateIpAddressRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :ip_address_ranges do |t|
      t.references :country
      t.inet :start_address, index: true
      t.inet :end_address, index: true
      t.inet :mask, index: true
      t.integer :count, index: true
      t.timestamps
    end
  end
end
