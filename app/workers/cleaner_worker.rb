class CleanerWorker < ScheduledWorker
  sidekiq_options retry: 4

  recurrence('0 0 * * 7 *', 'Every Sunday')

  def perform
    pokeballs = Pokeball.expired
    requests = Request.expired
    pokeballs_removed = 0
    requests_removed = 0

    pokeballs.each do |pokeball|
      pokeball.active_pokeballs.destroy_all
      CleanerMailer.cleaner_notification(pokeball.user, pokeball).deliver_now
      pokeball.destroy
      pokeballs_removed += 1
    end

    requests.each do |request|
      request.active_requests.destroy_all
      CleanerMailer.cleaner_notification(request.user, request).deliver_now
      request.destroy
      requests_removed += 1
    end

    Rails.logger.info("#{pokeballs_removed} Pokeballs removed.")
    Rails.logger.info("#{requests_removed} Requests removed.")
  end
end
