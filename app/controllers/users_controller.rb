class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  
  def new
    @user = User.new
    @pokemons = Pokemon.all
  end

  def create
    pokemons_ids = params[:pokemon]
    
    if pokemons_ids.size > 6 
      redirect_to new_user_path, flash: {error: 'Você precisa escolher no máximo 6 pokemons'}
    else 
      @user = User.create(params.require(:user).permit(:username,        
      :password))
      @user.pokemon_ids = pokemons_ids
      session[:user_id] = @user.id
      redirect_to trades_path
    end
  end
end
