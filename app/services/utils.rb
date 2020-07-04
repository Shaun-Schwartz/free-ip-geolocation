class Utils
  def self.int_to_ip(ipnum)
    ipnum = ipnum.to_i
  	return ((ipnum / 16777216) % 256).to_s + "." + ((ipnum / 65536) % 256).to_s + "." + ((ipnum / 256) % 256).to_s + "." + (ipnum % 256).to_s
  end

  def self.ip_to_int(ip)
    ipnum = IPAddr.new(ip)
  	return ipnum.to_i
  end

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
