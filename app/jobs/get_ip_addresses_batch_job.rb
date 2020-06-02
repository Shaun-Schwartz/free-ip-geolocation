class GetIpAddressesBatchJob
  include Sidekiq::Worker

  def perform
    Country.all.each do |country|
      GetIpAddressesJob.perform_async(country.id)
    end
  end
end
