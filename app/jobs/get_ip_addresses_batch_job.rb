class GetIpAddressesBatchJob
  include Sidekiq::Worker

  def perform
    Country.all.each do |country|
      GetIpAddressesJob.new.perform_async(country.id)
    end
  end
end
