class Worker
  include Sidekiq::Worker

  sidekiq_options expires_in: 1.week
end
