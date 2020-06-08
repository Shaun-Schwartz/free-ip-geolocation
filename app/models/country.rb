class Country < ApplicationRecord
  has_many :ip_address_ranges

  UPSERTABLE_COLUMNS = [:name, :abbreviation, :region, :city]

  def self.get_all
    GetCountriesJob.new.perform
  end

  def self.country_ip_addresses(country_id)
    GetIpAddressesJob.new
  end
end
