# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_03_012740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.string "generation"
    t.float "base_experience"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "from_user_id", null: false
    t.bigint "to_user_id", null: false
    t.string "pokemons_change"
    t.boolean "accepted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "changed_pokemons", default: false
    t.index ["from_user_id"], name: "index_trades_on_from_user_id"
    t.index ["to_user_id"], name: "index_trades_on_to_user_id"
  end

  create_table "user_pokemons", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pokemon_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pokemon_id"], name: "pokemon_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "trades", "users", column: "from_user_id", on_delete: :cascade
  add_foreign_key "trades", "users", column: "to_user_id", on_delete: :cascade
  add_foreign_key "user_pokemons", "pokemons"
  add_foreign_key "user_pokemons", "users"
end
