module Resettable
  extend ActiveSupport::Concern

  def create_confirmation_token_and_send_email
    create_reset_token
    UserMailer.with(user: self).reset_password.deliver_now
  end

  def create_reset_token
    payload = { email: email, exp: (Time.current + 2.days).to_i }
    token = Utils::Jwt.encode(payload)
    self.update(password_reset_token: token)
  end

  def reset_password(new_password)
    self.update(password: new_password, password_reset_token: nil)
  end
end
