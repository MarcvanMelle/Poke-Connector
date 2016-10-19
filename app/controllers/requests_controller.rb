class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
    @pokemon = pokemon_names
  end

  def create
    passed_pokemon = Pokemon.find_by(name: params[:requests][:pokemon])
    new_request = Request.new(request_params(passed_pokemon))
    if new_request.save
      redirect_to request_path(new_request.id)
      flash[:success] = "Pokemon succesfully requested!"
    else
      @pokemon = pokemon_names
      flash[:errors] = new_request.errors.full_messages.join(", ")
      render action: :new
    end
  end

  def edit
    @request = Request.find(params[:id])

    if @request.user != current_user
      flash[:errors] = "You may not edit another user's offer"
      redirect_to root_path
    end
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
    @request = Request.find(params[:id])
    if @request.user == current_user
      if @request.destroy
        flash[:success] = "Request successfully removed."
        redirect_to root_path
      else
        flash[:errors] = @request.errors.full_messages.join(", ")
        render action: :show
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  private

  def request_params(arg_pokemon)
    params.require(:requests).permit(:description, :level, :hpIV, :attIV, :defIV, :spaIV, :spdIV, :speIV).merge(pokemon: arg_pokemon, user: current_user)
  end

  def update_params
    params.require(:requests).permit(:description, :level, :hpIV, :attIV, :defIV, :spaIV, :spdIV, :speIV)
  end

  def pokemon_names
    @pokemon = []
    Pokemon.order(id: :asc).each do |pokemon|
      @pokemon << pokemon.name
    end
    @pokemon
  end
end
