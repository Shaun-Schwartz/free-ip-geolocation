class IpAddressRange < ApplicationRecord
  include Searchable

  belongs_to :country

  scope :find_by_ip, -> (ip) do
    ip = Utils.ip_to_int(ip)
    where("? BETWEEN start_int AND end_int", ip)
  end

  UPSERTABLE_COLUMNS = [:country_id, :start_ip, :end_ip, :start_int, :end_int, :mask]

  def self.search(ip)
    res = elastic_search(ip)
    country_id = res.first.country_id
    return '' unless country_id
    Country.find(country_id)
  end

  def self.elastic_search(ip)
    ip_int = Utils.ip_to_int(ip)
    @search_definition = {
      size: 1,
      query: {
        bool: {
          must: [
            {
              range: {
                start_int: {
                  lte: ip_int
                }
              }
            },
            {
              range: {
                end_int: {
                  gte: ip_int
                }
              }
            }
          ]
        }
      }
    }
    __elasticsearch__.search(@search_definition)
  end
end
