class LocationSerializer
  include FastJsonapi::ObjectSerializer
  set_id :mock_id
  attributes :country, :abbreviation, :region, :city
end
