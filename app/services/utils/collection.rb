class Utils::Collection
  def self.to_collection(object = [])
    if object.class == Array
      return object
    elsif object.class == String || Integer
      return [object]
    else
      raise "Object of type #{object.class} cannot be transformed into a collection"
      return object
    end
  end
end
