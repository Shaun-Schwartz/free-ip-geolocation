class IpAddressesController < ApplicationController
  def country
    ip_add_int = IPAddr.new(params.require(:ip)).to_i
    @country = Country.ip_address_ranges.where(range: ip_add_int)
  end
end
