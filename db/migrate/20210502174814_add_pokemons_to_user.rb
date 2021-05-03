class AddPokemonsToUser < ActiveRecord::Migration[6.1]
  def change
    create_table :user_pokemons do |t|
      t.references :user, foreign_key: true, index: {name: 'user_id'}
      t.references :pokemon, foreign_key: true, index: {name: 'pokemon_id'}

      t.timestamps
    end
  end
end


