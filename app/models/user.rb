class User < ApplicationRecord
  has_secure_password
  has_many :user_pokemon, dependent: :destroy
  has_many :pokemon, through: :user_pokemon

  def pokemons
    self.pokemon
  end
end

