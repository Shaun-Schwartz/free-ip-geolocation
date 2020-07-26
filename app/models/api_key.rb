class ApiKey < ApplicationRecord
  belongs_to :user, inverse_of: :api_keys

  scope :active, -> { where(active: true) }
  scope :order_by_active, -> { order('active DESC') }

  def self.create_new(user)
    token = SecureRandom.base64(32)
    new_api_key = user.api_keys.new(token: token)
    user.api_keys.update_all(active: false)
    new_api_key.save
  end
end
