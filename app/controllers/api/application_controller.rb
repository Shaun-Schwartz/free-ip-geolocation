class Api::ApplicationController < ActionController::Base

  def verify_api_token
    auth_token = request.headers['Authororization']
    user = User.joins(:api_keys)
                .where('api_keys.active = true')
                .where('api_keys.key = ?', auth_token)
                .last
    if !user
      render json: {}, status: 401
    end
  end
end
