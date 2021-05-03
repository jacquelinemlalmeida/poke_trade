class TradeController < ApplicationController
  include PokemonsHelper

  def show
  end

  def new
    @users = User.all
    @trade = Trade.new
  end

  def create
    from_user_pokemons = Pokemon.where(id: params[:pokemon][:from_user])
    to_user_pokemons = Pokemon.where(id: params[:pokemon][:to_user])
    to_user = User.where(id: params[:to_user_id])
  
    unless is_a_fair_trade?(from_user_pokemons, to_user_pokemons)
      redirect_to new_trade_path, flash: {error: 'Você precisa fazer uma troca justa, observe o base experience dos pokemons que deseja trocar.'}
    else 
      pokemons_change_json = {from_user: from_user_pokemons.pluck(:id), to_user: to_user_pokemons.pluck(:id)}.to_json
      params[:pokemons_change] = pokemons_change_json
      @trade = User.create(params.require(:trade).permit(:from_user, :to_user, :pokemons_change))
      
      redirect_to trade_history_show_path
    end
  end

  def calculate_base_experience
    pokemons = Pokemon.where(id: params[:from_user_pokemons])

    calculate_average_base_experience(pokemons)
  end
end
