require 'sidekiq-scheduler'
class ParseCsvBatchJob
  include Sidekiq::Worker

  def perform(filename = 'IP2LOCATION-LITE-DB3.CSV')
    batch = Sidekiq::Batch.new
    batch.on(:complete, ParseCsvBatchJob)
    batch.jobs do
      CSV.foreach(filename, headers: false) { |line| CsvLineJob.perform_async(line) }
    end
  end

  def on_complete(status, options)
    IpAddressRangeImportJob.perform_async
  end
end
