class Scrapers::GetCountries

  def initialize
    @url = Constants::COUNTRIES_URL
    @mechanize = Mechanize.new
    @mechanize.user_agent = Constants::USER_AGENTS.sample
    @mechanize.ignore_bad_chunking = true
    @mechanize.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def get_all
    page = @mechanize.get(@url)
    page.encoding = 'utf-8'
    country_ul = page.search('li.list-group-item')
    countries = country_ul.map do |li|
      {
        name: li.at('a').text,
        path: li.at('a').attributes['href'].value
      }
    end
    countries
  end
end
