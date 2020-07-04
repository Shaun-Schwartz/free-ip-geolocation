require 'sidekiq-scheduler'
class ParseCsvBatchJob
  include Sidekiq::Worker

  def perform(filename = 'ip_geolocations.csv')
    batch = Sidekiq::Batch.new
    batch.on(:complete, ParseCsvBatchJob)
    batch.jobs do
      CSV.foreach(filename, headers: false) { |line| CsvLineJob.perform_async(line) }
    end
  end

  def on_complete(status, options)
    puts '======================================================='
    puts 'ParseCsvBatchJob completed. Starting ElasticSearch import.'
    puts '======================================================='
    IpAddressRangeImportJob.perform_async
  end
end
