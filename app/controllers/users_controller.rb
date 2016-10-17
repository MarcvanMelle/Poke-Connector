class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:home, :show]

  def home
  end
end
