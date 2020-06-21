class IpAddressRange < ApplicationRecord
  include Searchable

  belongs_to :country

  scope :find_by_ip, -> (ip) do
    ip = Utils.ip_to_int(ip)
    where("? BETWEEN start_int AND end_int", ip)
  end

  UPSERTABLE_COLUMNS = [:country_id, :start_ip, :end_ip, :start_int, :end_int, :mask]
end
