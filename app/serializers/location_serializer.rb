class LocationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :country, :abbreviation, :region, :city, :updated_at
end
