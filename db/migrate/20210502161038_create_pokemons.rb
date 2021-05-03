class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :generation
      t.float :base_experience
      t.string :image
      t.timestamps
    end
  end
end
