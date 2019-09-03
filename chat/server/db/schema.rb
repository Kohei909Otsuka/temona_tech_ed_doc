# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_03_041226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "msgs", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.index ["room_id"], name: "index_msgs_on_room_id"
    t.index ["user_id"], name: "index_msgs_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "unread_msgs", force: :cascade do |t|
    t.bigint "msg_id", null: false
    t.bigint "room_id", null: false
    t.bigint "user_id", null: false
    t.index ["msg_id"], name: "index_unread_msgs_on_msg_id"
    t.index ["room_id"], name: "index_unread_msgs_on_room_id"
    t.index ["user_id"], name: "index_unread_msgs_on_user_id"
  end

  create_table "user_rooms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "hashed_password", null: false
  end

  add_foreign_key "msgs", "rooms"
  add_foreign_key "msgs", "users"
  add_foreign_key "unread_msgs", "msgs"
  add_foreign_key "unread_msgs", "rooms"
  add_foreign_key "unread_msgs", "users"
  add_foreign_key "user_rooms", "rooms"
  add_foreign_key "user_rooms", "users"
end
