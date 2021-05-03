class TradeController < ApplicationController
  include PokemonsHelper

  def history
    @trades = Trade.where(from_user_id: current_user.id)
    @trades = Trade.where(to_user_id: current_user.id) if @trades.empty?
  end

  def new
    @users = User.all
    @trade = Trade.new
  end

  def create
    from_user_pokemons = Pokemon.where(id: params[:pokemon][:from_user])
    to_user_pokemons = Pokemon.where(id: params[:pokemon][:to_user])
    
    pokemons_change_json = {from_user: from_user_pokemons.pluck(:id), to_user: to_user_pokemons.pluck(:id)}.to_json
    params[:pokemons_change] = pokemons_change_json
    params[:from_user_id] = current_user.id
   

    @trade = Trade.create(params.permit(:from_user_id, :to_user_id, :pokemons_change))
    
    redirect_to trades_path
    
  end

end
