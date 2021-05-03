class AddColumnChangedToTrade < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :changed_pokemons, :boolean, default: false
  end
end
