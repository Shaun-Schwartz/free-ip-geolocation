class Scrapers::IpRanges

  def initialize(country_id)
    @country = Country.find(country_id)
    @url = Constants::URL + @country.path
    @mechanize = Mechanize.new
    @mechanize.user_agent = Constants::USER_AGENTS.sample
    @mechanize.ignore_bad_chunking = true
    @mechanize.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def ranges
    page = @mechanize.get(@url)
    page.encoding = 'utf-8'
    table_data = page.search('table')[-1] # wtf -1
    table_data.search('tbody').search('tr').map do |tr|
      {
        start_ip: tr.children[1].text,
        end_ip: tr.children[3].text,
        count: tr.children[5].text
      }
    end
  end
end
