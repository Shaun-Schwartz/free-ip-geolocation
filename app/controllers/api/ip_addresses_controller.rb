class Api::IpAddressesController < Api::ApplicationController
  include IpValidations
  before_action :verify_api_token
  before_action :validate_ip_params

  def geolocation
    if @single_ip
      location = IpAddressRange.search(@single_ip)
      render json: LocationSerializer.new(location)
    end
  end

  private
  def validate_ip_params
    @single_ip = params[:ip] if params[:ip]
    validate_ip_address if @single_ip
  end
end
