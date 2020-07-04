module IpValidations
  extend ActiveSupport::Concern

  def valid_ip_array_length
    if @ip_array.length > ENV['MAX_IP_ARRAY_LENGTH'].to_i
      render json: { error: "The maximum length of an array of IPs is currently #{ENV['MAX_IP_ARRAY_LENGTH']}. This request includes #{@ip_array.length}"},
        status: :unprocessable_entity
      return
    end
  end

  def validate_ip_address
    unless Utils::Ip.is_valid_ip_address?(@single_ip)
      render json: { error: "That doesn't look like an ipv4 address"},
        status: :unprocessable_entity
      return
    end
  end

  def validate_ip_addresses
    invalid_ip_array = []
    @ip_array.each do |ip|
      next if Utils::Ip.is_valid_ip_address?(ip)
      invalid_ip_array.push(ip)
      if invalid_ip_array.present?
        render json: { error: "That #{invalid_ip_array} doesn't look like an ipv4 address"},
          status: :unprocessable_entity
        return
      end
    end
  end
end
