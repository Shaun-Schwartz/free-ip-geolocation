class IpAddressesController < ApplicationController
  def geolocation
    ip = params.require(:ip)
    address = IpAddressRange.find_by_ip(ip).first
    render json: CountrySerializer.new(address.country)
  end

  def geolocations
    ips = params.require(:ips)
    ips_collection = Utils.to_collection(ips)
    locations = ips_collection.each do |ip|
      IpAddressRange.find_by_ip(ip).first.country
    end
    render json: CountrySerializer.new(locations).serializable_hash
  end
end
