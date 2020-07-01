class Location < ApplicationRecord
  has_many :ip_address_ranges
end
