module Confirmable
  extend ActiveSupport::Concern
  after_create :create_confirmation_token

  def create_confirmation_token
    token = Digest::SHA1.hexdigest(SecureRandom.hex(10)
    self.update(confirmation_token: token)
  end
end
