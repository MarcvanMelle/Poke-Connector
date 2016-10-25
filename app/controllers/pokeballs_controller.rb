class PokeballsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    @pokeballs = Pokeball.all
  end

  def show
    @pokeball = Pokeball.find(params[:id])
    @active = @pokeball.active_pokeballs.find_by(user: current_user)
  end

  def new
    @pokeball = Pokeball.new
    @pokemon = pokemon_names
    respond_to do |format|
      format.html
      format.json do
        render json: @pokemon.to_json
      end
    end
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

    if @pokeball.user != current_user
      flash[:errors] = "You may not edit another user's offer"
      redirect_to root_path
    end
  end

  def update
    @pokeball = Pokeball.find(params[:id])
    if @pokeball.user == current_user
      if @pokeball.update(update_params)
        flash[:success] = "Offer successfully updated!"
        redirect_to pokeball_path(@pokeball.id)
      else
        flash[:errors] = @pokeball.errors.full_messages.join(", ")
        render action: :edit
      end
    end
  end

  def destroy
    @pokeball = Pokeball.find(params[:id])
    if @pokeball.user == current_user
      if @pokeball.destroy
        flash[:success] = "Offer successfully removed."
        redirect_to root_path
      else
        flash[:errors] = @pokeball.errors.full_messages.join(", ")
        render action: :show
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
