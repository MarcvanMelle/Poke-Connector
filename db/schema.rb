# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171006170800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_pokeballs", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pokeball_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokeball_id"], name: "index_active_pokeballs_on_pokeball_id"
    t.index ["user_id"], name: "index_active_pokeballs_on_user_id"
  end

  create_table "active_requests", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_active_requests_on_request_id"
    t.index ["user_id"], name: "index_active_requests_on_user_id"
  end

  create_table "pokeballs", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pokemon_id", null: false
    t.text "description"
    t.integer "level"
    t.integer "hpIV"
    t.integer "attIV"
    t.integer "defIV"
    t.integer "spaIV"
    t.integer "spdIV"
    t.integer "speIV"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender", null: false
    t.index ["pokemon_id"], name: "index_pokeballs_on_pokemon_id"
    t.index ["user_id"], name: "index_pokeballs_on_user_id"
  end

  create_table "pokemons", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "sprite", null: false
    t.integer "pokedex_id", null: false
    t.string "typeA", null: false
    t.string "typeB"
  end

  create_table "requests", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pokemon_id", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id"], name: "index_requests_on_pokemon_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "friend_code"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
