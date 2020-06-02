class Mappers::Base
  attr_accessor :object_hash

  def initialize(object_hash)
    @object_hash = object_hash
  end

  def mapped
    Hash[mapped_attributes.map { |attr| [attr, send(attr)] }]
  end

  def mapped_attributes
    raise 'must impliment mapped attributes'
  end
end
