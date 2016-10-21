class PokemonsController < ApplicationController
  def index
    @pokemon = Pokemon.order(id: :asc)
  end
end
