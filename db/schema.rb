# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131012203919) do

  create_table "boards", force: true do |t|
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boards", ["game_id"], name: "index_boards_on_game_id"

  create_table "games", force: true do |t|
    t.boolean  "computers_move"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "game_id"
    t.integer  "board_id"
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["board_id"], name: "index_players_on_board_id"
  add_index "players", ["game_id"], name: "index_players_on_game_id"

  create_table "squares", force: true do |t|
    t.integer  "board_id"
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "x"
    t.integer  "y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "squares", ["board_id"], name: "index_squares_on_board_id"
  add_index "squares", ["game_id"], name: "index_squares_on_game_id"
  add_index "squares", ["player_id"], name: "index_squares_on_player_id"

end
