class Api::IpAddressesController < Api::ApplicationController
  include IpValidations
  before_action :verify_api_token
  before_action :validate_ip_params

  def geolocation
    if @single_ip
      location = IpAddressRange.search(@single_ip)
      render json: LocationSerializer.new(location)
    elsif @ip_array
      locations = @ip_array.map do |ip|
        IpAddressRange.search(ip)
      end
      if locations
        render json: LocationSerializer.new(locations).serializable_hash
      end
    end
  end

  private
  def validate_ip_params
    @single_ip = params[:ip] if params[:ip]
    if params[:ips]
      @ip_array = Utils::Collection.to_collection(params[:ips])
    end
    if @single_ip
      validate_ip_address
    elsif @ip_array
      if valid_ip_array_length
      else validate_ip_addresses
      end
    end
  end
end
