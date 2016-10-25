class Api::V1::PokeballsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    pokeballs = Pokeball.all
    users = User.all
    pokemon = Pokemon.all
    render json: { pokeballs: pokeballs, users: users, pokemon: pokemon }
  end

  def show
    pokeball = Pokeball.find(params[:id])
    pokeballOwner = pokeball.user
    pokemon = pokeball.pokemon
    active = pokeball.active_pokeballs.find_by(user: current_user)
    render json: { pokemon: pokemon, pokeball: pokeball, owner: pokeballOwner, active: active, user: current_user }
  end

  def new
    pokeball = Pokeball.new
    pokemon = pokemon_names
    render json: { pokemon: pokemon, user: current_user }
  end

  def create
    passed_pokemon = Pokemon.find_by(name: params[:pokeballs][:pokemon])
    new_pokeball = Pokeball.new(pokeball_params(passed_pokemon))
    if new_pokeball.save
      flash[:success] = "Pokemon succesfully offered!"
      render json: { path: "/pokeballs/#{new_pokeball.id}" }
    else
      pokemon = pokemon_names
      flash[:errors] = new_pokeball.errors.full_messages.join(', ')
      render json: { errors: flash[:errors], pokemon: pokemon }
    end
  end

  def edit
    pokeball = Pokeball.find(params[:id])
    pokemon = pokeball.pokemon
    if pokeball.user != current_user
      flash[:errors] = "You may not edit another user's offer"
      redirect_to root_path
    end
    render json: { pokeball: pokeball, pokemon: pokemon }
  end

  def update
    pokeball = Pokeball.find(params[:id])
    if pokeball.user == current_user
      if pokeball.update(update_params)
        flash[:success] = "Offer successfully updated!"
        render json: { path: "/pokeballs/#{pokeball.id}" }
      else
        flash[:errors] = pokeball.errors.full_messages.join(", ")
        render json: { errors: flash[:errors], pokeball: pokeball, pokemon: pokeball.pokemon }
      end
    end
  end

  def destroy
    pokeball = Pokeball.find(params[:id])
    if pokeball.user == current_user
      if pokeball.destroy
        render json: { path: "/", success: "Offer successfully removed." }
      else
        flash[:errors] = pokeball.errors.full_messages.join(", ")
        render json: { path: "/pokeballs/#{pokeball.id}/edit", errors: flash[:errors] }
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  private

  def pokeball_params(arg_pokemon)
    params.require(:pokeballs).permit(:description, :level, :hpIV, :attIV, :defIV, :spaIV, :spdIV, :speIV).merge(pokemon: arg_pokemon, user: current_user)
  end

  def update_params
    params.require(:pokeballs).permit(:description, :level, :hpIV, :attIV, :defIV, :spaIV, :spdIV, :speIV)
  end

  def pokemon_names
    @pokemon = []
    Pokemon.order(id: :asc).each do |pokemon|
      @pokemon << pokemon.name
    end
    @pokemon
  end
end
