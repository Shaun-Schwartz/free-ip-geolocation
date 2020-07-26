require 'sidekiq-scheduler'
class CleanUpRequestsBatchJob
  include Sidekiq::Worker

  def perform
    User.all.each do |user|
      CleanUpRequestsJob.perform_async(user.id)
    end
  end
end
