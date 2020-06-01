class GetCountriesJob
  include Sidekiq::Worker

  def perform
    Scrapers::GetCountries.new.get
  end
end
