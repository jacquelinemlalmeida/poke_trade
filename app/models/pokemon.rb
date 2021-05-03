class Pokemon < ApplicationRecord
  has_many :user_pokemon, dependent: :destroy
  has_many :user, through: :user_pokemon
end