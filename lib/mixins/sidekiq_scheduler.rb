module SidekiqScheduler
  def recurrence(cron, readable_cron)
    return if Rails.env.test? || defined? Rails::Console
    @_cron = cron
    Sidekiq::Cron::Job.create(name: "#{self.name} - #{readable_cron}", cron: cron, klass: self.name)
  end
end
