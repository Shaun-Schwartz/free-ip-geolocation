class ApiKey < ApplicationRecord
  belongs_to :user, inverse_of: :api_keys
end
