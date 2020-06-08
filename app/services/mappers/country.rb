class Mappers::Country < Mappers::Base
  def mapped_attributes
    [:name, :abbreviation]
  end

  def name
    object_hash[:name]
  end

  def abbreviation
    object_hash[:abbreviation]
  end
end
