class User < ApplicationRecord
  has_secure_password
  has_many :api_keys
  has_one :active_api_key, -> { where(active: true) }, class_name: :api_key
  before_save :create_api_key

  def create_api_key
    self.api_key.key = SecureRandom.hex(20)
  end
end
