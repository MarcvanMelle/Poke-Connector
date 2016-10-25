class Api::V1::PokemonsController < ApplicationController
  def index
    render json: { user: current_user }
  end
end
