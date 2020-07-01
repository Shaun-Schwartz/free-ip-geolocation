class Mappers::Csv
  attr_reader :line

  def initialize(line)
    @line = line
  end

  def mapped_attributes
    {
      start_ip: start_ip,
      end_ip: end_ip,
      start_int: start_int,
      end_int: end_int,
      abbreviation: abbreviation,
      country: country,
      region: region,
      city: city
    }
  end

  def start_ip
    Utils::Ip.int_to_ip(line[0])
  end

  def end_ip
    Utils::Ip.int_to_ip(line[1])
  end

  def start_int
    line[0].to_i
  end

  def end_int
    line[1].to_i
  end

  def abbreviation
    line[2]
  end

  def country
    line[3]
  end

  def region
    line[4]
  end

  def city
    line[5]
  end
end
