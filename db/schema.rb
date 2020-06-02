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

ActiveRecord::Schema.define(version: 2020_05_31_011005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorite_things", id: :serial, force: :cascade do |t|
    t.integer "member_id", null: false
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_favorite_things_on_member_id"
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "rank", null: false
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ship_id"
    t.index ["ship_id"], name: "index_members_on_ship_id"
  end

  create_table "resets", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ships", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "registry"
    t.string "class_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "favorite_things", "members"
  add_foreign_key "members", "ships"
end
