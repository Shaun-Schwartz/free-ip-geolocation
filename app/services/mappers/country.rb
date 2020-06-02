class Mappers::Country < Mappers::Base
  def mapped_attributes
    [:name, :path]
  end

  def name
    object_hash[:name]
  end

  def path
    object_hash[:path]
  end
end
