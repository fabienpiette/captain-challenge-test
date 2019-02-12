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

ActiveRecord::Schema.define(version: 2019_02_12_110348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.integer "fighter_left_score", default: 0
    t.integer "fighter_right_score", default: 0
    t.integer "damage", default: 0
    t.integer "left_hp", default: 0
    t.integer "right_hp", default: 0
    t.bigint "current_fighter_id"
    t.bigint "fight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_fighter_id"], name: "index_actions_on_current_fighter_id"
    t.index ["fight_id"], name: "index_actions_on_fight_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "health_points", default: 20, null: false
    t.integer "attack_points", default: 1, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.bigint "weapon_id"
    t.bigint "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_equipment_on_character_id"
    t.index ["weapon_id"], name: "index_equipment_on_weapon_id"
  end

  create_table "fights", force: :cascade do |t|
    t.bigint "fighter_left_id"
    t.bigint "fighter_right_id"
    t.bigint "winning_character_id"
    t.bigint "losing_character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fighter_left_id"], name: "index_fights_on_fighter_left_id"
    t.index ["fighter_right_id"], name: "index_fights_on_fighter_right_id"
    t.index ["losing_character_id"], name: "index_fights_on_losing_character_id"
    t.index ["winning_character_id"], name: "index_fights_on_winning_character_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.integer "damage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
