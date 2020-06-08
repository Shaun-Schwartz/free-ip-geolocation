class ParseCsvBatchJob
  include Sidekiq::Worker

  def perform(filename = 'IP2LOCATION-LITE-DB3.CSV')
    File.open(filename, 'r').each do |line|
      csv_line = CSV.parse(line).flatten
      next if csv_line.first == "0"
      CsvLineJob.perform_async(csv_line)
    end
  end
end
