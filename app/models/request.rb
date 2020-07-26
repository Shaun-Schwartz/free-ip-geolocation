class Request < ApplicationRecord
  belongs_to :user, inverse_of: :requests
end
