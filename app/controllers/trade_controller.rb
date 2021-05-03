class TradeController < ApplicationController
  include PokemonsHelper

  def history
    @trades = Trade.where('from_user_id = ? OR to_user_id = ?', current_user.id, current_user.id)
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

  def accepted 
    trade = Trade.find_by(id: params[:trade_id])
    pokemons = JSON.parse trade[:pokemons_change]
    from_user_pokemons = User.find_by(id: trade.from_user_id).pokemons.pluck(:id)
    to_user_pokemons = User.find_by(id: trade.to_user_id).pokemons.pluck(:id)

    return trade.update({accepted: false, changed_pokemons: true}) if params[:accepted_flag] == '0'

    new_from_user_pokemons = from_user_pokemons - pokemons["from_user"] + pokemons["to_user"]

    new_to_user_pokemons = to_user_pokemons - pokemons["to_user"] + pokemons["from_user"]

    User.find_by(id: trade.to_user_id).pokemon_ids = new_to_user_pokemons
    current_user.pokemon_ids = new_from_user_pokemons

    trade.update({accepted: true, changed_pokemons: true})

    redirect_to trades_path
  end

  def cancel 
    Trade.find_by(id: params[:trade_id]).destroy
    redirect_to trades_path
  end

end
