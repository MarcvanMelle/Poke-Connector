class PokemonsController < ApplicationController
  def index
    @pokemon = Pokemon.order(id: :asc)
  end

  def clean
    CleanerWorker.perform_async
    redirect_to root_path
  end
end
