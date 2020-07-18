class User < ApplicationRecord
  include Confirmable
  has_secure_password
  has_many :api_keys, inverse_of: :user
  has_one :active_api_key, -> { where(active: true) }, class_name: :api_key
  after_create :create_confirmation_token_and_send_email

  def create_api_key
    self.api_keys.update_all(active: false) if self.api_keys.present?
    self.api_keys.create(key: SecureRandom.hex(20))
  end
end
