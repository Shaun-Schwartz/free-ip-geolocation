class Api::ApplicationController < ActionController::Base
  include Api::Concerns::CurrentApiUser

  helper_method :current_api_user

  def verify_api_token
    auth_token = request.headers['Authorization']
    user = User.joins(:api_keys)
                .where('api_keys.active = true')
                .where('api_keys.token = ?', auth_token)
                .last
    if !user
      render json: {}, status: 401
    end
  end

  def verify_api_call_limit
    #requests_30_days = User.joins(:requests)

  end
end
