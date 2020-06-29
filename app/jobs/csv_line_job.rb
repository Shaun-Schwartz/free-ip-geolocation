class CsvLineJob
  include Sidekiq::Worker
  attr_accessor :properties

  def perform(line)
    return if line.empty?
    @properties = Mappers::Csv.new(line).mapped_attributes
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
    ip_address_range = @country.ip_address_ranges.find_or_create_by(
      start_ip: @properties[:start_ip],
      end_ip: @properties[:end_ip]
    )
    ip_address_range.update(
      country_id: @country.id,
      start_int: @properties[:start_int],
      end_int: @properties[:end_int],
    )
  end
end
