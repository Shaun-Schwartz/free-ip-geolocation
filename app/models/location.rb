class Location < ApplicationRecord
  has_many :ip_address_ranges

  def mock_id
    "#{SecureRandom.hex(2)}"
  end
end
