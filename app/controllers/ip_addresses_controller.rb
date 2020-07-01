class IpAddressesController < ApplicationController
  before_action :validate_ip_params

  def geolocation
    if @single_ip
      location = IpAddressRange.search(@single_ip)
      render json: LocationSerializer.new(location)
    elsif @ip_array
      locations = @ip_array.map do |ip|
        IpAddressRange.search(ip)
      end
      render json: LocationSerializer.new(locations).serializable_hash
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
      validate_ip_addresses
    end
  end

  def validate_ip_address
    if @single_ip
      unless Utils::Ip.validate_is_ip_address(@single_ip)
        render json: { error: "1 that doesn't look like an ip address"},
          status: :unprocessable_entity
        end
    end
  end

  def validate_ip_addresses
    @ip_array.each do |ip|
      unless Utils::Ip.validate_is_ip_address(ip)
        render json: { error: "2 that doesn't look like an ip address"},
          status: :unprocessable_entity
      end
    end
  end
end
