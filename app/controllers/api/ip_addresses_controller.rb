class Api::IpAddressesController < Api::ApplicationController
  include IpValidations
  include Api::Concerns::CurrentApiUser
  before_action :verify_api_token
  before_action :current_api_user
  before_action :validate_ip_params

  def geolocation
    current_api_user.create_request(@ip)
    location = IpAddressRange.search(@ip)
    render json: LocationSerializer.new(location)
  end

  private
  def validate_ip_params
    @ip = params.require(:ip)
    validate_ip_address
  end
end
