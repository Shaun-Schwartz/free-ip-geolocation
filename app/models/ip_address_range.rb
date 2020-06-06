class IpAddressRange < ApplicationRecord
  belongs_to :country

  UPSERTABLE_COLUMNS = [:country_id, :start_ip, :end_ip, :ip_range, :mask, :count]
end
