class Api::V1::RequestsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    requests = Request.all
    users = User.all
    pokemon = Pokemon.all
    render json: { requests: requests, users: users, pokemon: pokemon }
  end

  def show
    request = Request.find(params[:id])
    request_owner = request.user
    pokemon = request.pokemon
    active = request.active_requests.find_by(user: current_user)
    render json: { pokemon: pokemon, request: request, owner: request_owner, active: active, user: current_user }
  end

  def new
    pokemon = pokemon_names
    render json: { pokemon: pokemon, user: current_user }
  end

  def create
    passed_pokemon = Pokemon.find_by(name: params[:requests][:pokemon])
    new_request = Request.new(request_params(passed_pokemon))
    if new_request.save
      flash[:success] = "Pokemon succesfully offered!"
      render json: { path: "/requests/#{new_request.id}" }
    else
      pokemon = pokemon_names
      flash[:errors] = new_request.errors.full_messages.join(', ')
      render json: { errors: flash[:errors], pokemon: pokemon }
    end
  end

  def edit
    request = Request.find(params[:id])
    pokemon = request.pokemon
    if request.user != current_user
      flash[:errors] = "You may not edit another user's offer"
      redirect_to root_path
    end
    render json: { request: request, pokemon: pokemon }
  end

  def update
    @request = Request.find(params[:id])
    if @request.user == current_user
      if @request.update(update_params)
        flash[:success] = "Request successfully updated!"
        redirect_to request_path(@request.id)
      else
        flash[:errors] = @request.errors.full_messages.join(", ")
        render action: :edit
      end
    end
  end

  def destroy
    request = Request.find(params[:id])
    if request.user == current_user
      if request.destroy
        render json: { path: "/", success: "Request successfully removed." }
      else
        flash[:errors] = request.errors.full_messages.join(", ")
        render json: { path: "/requests/#{request.id}/edit", errors: flash[:errors] }
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  private

  def request_params(arg_pokemon)
    params.require(:requests).permit(:description).merge(pokemon: arg_pokemon, user: current_user)
  end

  def update_params
    params.require(:requests).permit(:description)
  end

  def pokemon_names
    @pokemon = []
    Pokemon.order(id: :asc).each do |pokemon|
      @pokemon << pokemon.name
    end
    @pokemon
  end
end
