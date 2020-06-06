class GetIpAddressesJob
  include Sidekiq::Worker
  attr_accessor :ranges_for_upsert

  def perform(country_id)
    @country = Country.find(country_id)
    @responses = Scrapers::IpRanges.new(country_id).ranges
    @existing_ip_address_ranges = @country.ip_address_ranges
    @country_ip_address_range_previous_count = @existing_ip_address_ranges.count
    collect_ranges
    upsert_and_delete
  end

  def collect_ranges
    @ranges_for_upsert = []
    @responses.each do |response|
      start_ip = response[:start_ip]
      end_ip = response[:end_ip]
      ranges_for_upsert.push({
        country_id: @country.id,
        start_ip: start_ip,
        end_ip: end_ip,
        count: response[:count].sub(',','').to_i,
        ip_range: IPAddr.new(start_ip).to_i..IPAddr.new(end_ip).to_i
      })
    end
  end

  def upsert_and_delete
    result = UpsertData.new(@ranges_for_upsert).ip_address_ranges
    saved_ids = result.ids
    ranges_to_delete = @country.ip_address_ranges.where.not(id: saved_ids)
    ranges_to_delete.delete_all
  end
end
