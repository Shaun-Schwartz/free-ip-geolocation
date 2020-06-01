class GetIpAddressesJob
  include Sidekiq::Worker

  def perform(country_id)
    responses = Scrapers::IpRanges.new(country_id).ranges
    @country = Country.find(country_id)
    responses.each do |response|
      @country.ip_address_ranges.create(
        start_address: response['start_address'],
        end_address: response['end_address'],
        count: response['count']
      )
    end
  end
end
