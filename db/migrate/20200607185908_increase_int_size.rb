class IncreaseIntSize < ActiveRecord::Migration[6.0]
  def up
    change_column :ip_address_ranges, :start_int, :integer, limit: 8, index: true
    change_column :ip_address_ranges, :end_int, :integer, limit: 8, index: true
  end
  def down
    change_column :ip_address_ranges, :start_int, :integer
    change_column :ip_address_ranges, :end_int, :integer
  end
end
