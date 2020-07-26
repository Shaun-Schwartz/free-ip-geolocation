class CleanUpRequestsJob
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.requests.where('created_at < ? ', Time.current - 30.days).delete_all
  end
end
