class IpAddressRange < ApplicationRecord
  include Searchable
  belongs_to :location, optional: true

  def self.search(ip)
    res = elastic_search(ip)
    return unless res.first
    location_id = res.first.location_id
    Location.find(location_id)
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
