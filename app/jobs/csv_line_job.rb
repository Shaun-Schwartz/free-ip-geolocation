require 'sidekiq-scheduler'
class CsvLineJob
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  attr_accessor :properties

  def perform(line)
    return if line.empty?
    @properties = Mappers::Csv.new(line).mapped_attributes
    save_location
    save_ip_range
  end

  def save_location
    @location = Location.find_or_create_by(
      country: properties[:country],
      abbreviation: properties[:abbreviation],
      region: properties[:region],
      city: properties[:city]
    )
  end

  def save_ip_range
    ip_address_range = IpAddressRange.find_or_initialize_by(
      start_ip: properties[:start_ip],
      end_ip: properties[:end_ip]
    )
    ip_address_range.update(
      location_id: @location.id,
      start_int: properties[:start_int],
      end_int: properties[:end_int],
    )
  end
end
