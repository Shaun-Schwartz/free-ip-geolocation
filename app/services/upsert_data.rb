class UpsertData
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def countries
    ActiveRecord::Base.connection_pool.with_connection do
      Country.import data, on_duplicate_key_update: {
        conflict_target: [:name], columns: Country::UPSERTABLE_COLUMNS
      }
    end
  end

  def ip_address_range
    binding.pry
    ActiveRecord::Base.connection_pool.with_connection do
      IpAddressRange.import data, on_duplicate_key_update: {
        conflict_target: [:country_id, :start_ip, :end_ip], columns: IpAddressRange::UPSERTABLE_COLUMNS
      }
    end
  end
end
