class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.references :from_user, index: true, null: false, foreign_key: {to_table: :users, on_delete: :cascade}
      t.references :to_user, references: :user, index: true, null: false, foreign_key: {to_table: :users, on_delete: :cascade}
      t.string :pokemons_change
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
