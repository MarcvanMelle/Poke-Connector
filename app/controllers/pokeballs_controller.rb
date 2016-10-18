class PokeballsController < ApplicationController
  def index
    @pokeballs = Pokeball.all
  end

  def show
    @pokeball = Pokeball.find(params[:id])
  end

  def new
    @pokeball = Pokeball.new
  end

  def create

  end

  def edit
    @pokeball = Pokeball.find(params[:id])
  end

  def update

  end

  def destroy

  end
end
