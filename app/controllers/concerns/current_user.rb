module CurrentUser
  extend ActiveSupport::Concern

  def current_user_token(user_id = nil)
    return unless user_id
    current_user = User.find(user_id: user_id[:user_id])
    Utils::Jwt.payload = {user_id: user_id, exp: Time.current + 2.weeks}
    JWT.encode payload, HMAC_SECRET, 'HS256'
  end

  def set_current_user
    jwt_token = session[:token]
    email = Utils::Jwt.email_from_token(jwt_token)
    current_user = User.find_by(email: email)
    return current_user
  end
end
