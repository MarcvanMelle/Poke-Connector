class CleanerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false

  recurrence { weekly }

  def perform
    pokeballs = Pokeball.all
    requests = Request.all
    now = DateTime.now
    pokeballs.each do |pokeball|
      if pokeball.created_at < now - 14
        puts "Pokeball cleaned"
        pokeball.active_pokeballs.destroy_all
        CleanerMailer.cleaner_notification(pokeball.user, pokeball).deliver_now
        pokeball.destroy
      else
        puts "Offer not expired"
      end
    end
    requests.each do |request|
      if request.created_at < now - 14
        puts "PokeRequest cleaned"
        request.active_requests.destroy_all
        CleanerMailer.cleaner_notification(request.user, request).deliver_now
        request.destroy
      else
        puts "Offer not expired"
      end
    end
    puts "Pokemon cleaned"
  end
end
