class IpAddressRangeImportJob
  include Sidekiq::Worker

  def perform
    IpAddressRange.import(force: true)
  end
end
