class Jobs::Monitor
  attr_accessor :job_name, :queue_name

  def initialize(job_name, queue_name = nil)
    @job_name = job_name
    @queue_name = queue_name
  end

  def running?
    queue = queue_name.nil? ? Sidekiq::Queue.all : Sidekiq::Queue.new(queue_name)
    queue.each do |job|
      return false if queue.size == 0
      return true if job.klass == job_name
    end
  end

  def retrying?
    query = Sidekiq::RetrySet.new
    return false if query.size == 0
    query.scan(job_name).select do |job|
      return true if job.klass == job_name
    end
  end
end
