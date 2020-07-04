class Utils::Ip
  def self.int_to_ip(ipnum)
    ipnum = ipnum.to_i
  	return ((ipnum / 16777216) % 256).to_s + "." + ((ipnum / 65536) % 256).to_s + "." + ((ipnum / 256) % 256).to_s + "." + (ipnum % 256).to_s
  end

  def self.ip_to_int(ip)
    ipnum = IPAddr.new(ip)
  	return ipnum.to_i
  end

  def self.is_valid_ip_address?(ip)
    return false if ip.nil?
    # Doesn't properly validate. Private IPs will match, as will something like 999.999.999.999
    ip_regex = /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/
    !(ip =~ ip_regex).nil?
  end
end
