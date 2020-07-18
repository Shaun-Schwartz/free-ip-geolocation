module Confirmable
  extend ActiveSupport::Concern

  def create_confirmation_token_and_send_email
    create_confirmation_token
    UserMailer.with(user: self).confirm_email.deliver_now
  end

  def create_confirmation_token
    token = Utils::Jwt.encode({email: email})
    self.update(confirmation_token: token)
  end

  def confrimed?
    confirmed_at.present?
  end

  def self.confirm_email(token)
    email = Utils::Jwt.email_from_token(token)
    user = User.find_by(email: email)
    return 'no user found' unless user
    user.update(confirmed_at: Time.current)
  end

  def confirm!
    self.update(confirmed_at: Time.current)
  end
end
