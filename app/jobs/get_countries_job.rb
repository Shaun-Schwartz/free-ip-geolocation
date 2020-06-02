class GetCountriesJob
  include Sidekiq::Worker

  def perform
    scraped_countries = Scrapers::GetCountries.new.get_all
    mapped_countries = scraped_countries.map do |country|
      Mappers::Country.new(country).mapped
    end
    UpsertData.new(mapped_countries).countries
  end
end
