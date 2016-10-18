class PokeballsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pokeballs = Pokeball.all
  end

  def show
    @pokeball = Pokeball.find(params[:id])
  end

  def new
    @pokeball = Pokeball.new
    @pokemon = pokemon_names
  end

  def create
    passed_pokemon = Pokemon.find_by(name: params[:pokeballs][:pokemon])
    new_pokeball = Pokeball.new(pokeball_params(passed_pokemon))
    if new_pokeball.save
      redirect_to pokeball_path(new_pokeball.id)
      flash[:success] = "Pokemon succesfully offered!"
    else
      @pokemon = pokemon_names
      flash[:errors] = new_pokeball.errors.full_messages.join(", ")
      render action: :new
    end
  end

  def edit
    @pokeball = Pokeball.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def pokeball_params(arg_pokemon)
    params.require(:pokeballs).permit(:description, :level, :hpIV, :attIV, :defIV, :spaIV, :spdIV, :speIV).merge(pokemon: arg_pokemon, user: current_user)
  end

  def pokemon_names
    @pokemon = []
    Pokemon.order(id: :asc).each do |pokemon|
      @pokemon << pokemon.name
    end
    @pokemon
  end
end
