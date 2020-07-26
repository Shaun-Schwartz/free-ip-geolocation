class Api::ApplicationController < ActionController::Base
  include Api::Concerns::CurrentApiUser
  helper_method :current_api_user
  before_action :verify_api_token
  before_action :rate_limit_not_reached

  def verify_api_token
    if !current_api_user
      render json: {}, status: 401 and return
    end
  end

  def rate_limit_not_reached
    if current_api_user.requests.count >= User::FREE_RATE_LIMIT
      render json: {}, status: 429 and return
    end
  end
end
