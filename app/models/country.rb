class Country < ApplicationRecord
  has_many :ip_address_ranges

  UPSET_COLUMNS = [:name, :path]

  def self.get_all
    GetCountriesJob.new.perform
  end

  def self.country_ip_addresses(id)
    GetIpAddressesJob.new
  end
end
