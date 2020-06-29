class ParseCsvBatchJob
  include Sidekiq::Worker

  def perform(filename = 'ip_geolocations.csv')
    batch = Sidekiq::Batch.new
    batch.on(:success, ParseCsvBatchJob)
    batch.jobs do
      File.open(filename, 'r').each do |line|
        csv_line = CSV.parse(line).flatten
        next if csv_line.first == "0"
        CsvLineJob.perform_async(csv_line)
      end
    end
  end

  def on_success(status, options)
    puts '======================================================='
    puts 'ParseCsvBatchJob completed. Starting ElasticSearch import.'
    puts '======================================================='
    IpAddressRangeImportJob.perform_async
  end
end
