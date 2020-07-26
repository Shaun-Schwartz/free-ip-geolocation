module Api::Concerns::CurrentApiUser
  extend ActiveSupport::Concern

  def current_api_user
    auth_token = request.headers['Authorization']
    return unless auth_token
    current_user = current_user_from_token(auth_token)
    return current_user
  end

  def current_user_from_token(token)
    user = User.joins(:api_keys)
                .where('api_keys.active = true')
                .where('api_keys.token = ?', token)
                .last
  end
end
