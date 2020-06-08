class Mappers::IpAddressRange < Mappers::Base
  def mapped_attributes
    [:country_id, :start_ip, :end_ip, :start_int, :end_int, :mask]
  end

  def country_id
    object_hash[:country_id]
  end

  def start_ip
    object_hash[:start_ip]
  end

  def end_ip
    object_hash[:end_ip]
  end

  def start_int
    object_hash[:start_int]
  end

  def end_int
    object_hash[:end_int]
  end

  def mask
    object_hash[:mask]
  end
end
