class CsvLineJob
  include Sidekiq::Worker
  attr_accessor :properties

  def perform(line)
    return if line.empty?
    @properties = {
      start_ip: Utils.int_to_ip(line[0]),
      end_ip: Utils.int_to_ip(line[1]),
      start_int: line[0].to_i,
      end_int: line[1].to_i,
      abbreviation: line[2],
      country: line[3],
      region: line[4],
      city: line[5]
    }
    save_country
    upsert_ip_range
  end

  def save_country
    @country = Country.find_or_create_by(
      name: properties[:country],
      abbreviation: properties[:abbreviation],
      region: properties[:region],
      city: properties[:city]
    )
  end

  def upsert_ip_range
    mapped_ip_range = Mappers::IpAddressRange.new(@properties).mapped
    @country.ip_address_ranges.create(mapped_ip_range)
  end
end
