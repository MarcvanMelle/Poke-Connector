class CleanerWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform
    pokeballs = Pokeball.all
    requests = Request.all
    now = DateTime.now
    puts "Pokemon cleaned"
  end
end
