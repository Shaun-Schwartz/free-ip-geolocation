class CountrySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :abbreviation, :region, :city, :updated_at
end
