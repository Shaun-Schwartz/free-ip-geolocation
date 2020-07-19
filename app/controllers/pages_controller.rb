class PagesController < ApplicationController
  skip_before_action :authorized

  def home
    # @request_ip = request.remote_ip
    @request_ip = '193.37.253.69' # TODO: change before deploying
    if @request_ip == Constants::LOCALHOST_IPV4
      @location = Location.first(100).sample
    else
      @location = IpAddressRange.search(@request_ip)
    end
    @json = LocationSerializer.new(location)
    render 'pages/home'
  end
end
