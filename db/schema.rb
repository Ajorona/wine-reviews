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

ActiveRecord::Schema.define(version: 2020_07_22_060203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "iso"
    t.string "name"
    t.string "printable_name"
    t.string "iso3"
    t.integer "numcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "designations", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wineries_id"
    t.index ["wineries_id"], name: "index_designations_on_wineries_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.bigint "parent_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_location_id"], name: "index_locations_on_parent_location_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "description"
    t.integer "points"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wines_id"
    t.bigint "tasters_id"
    t.index ["tasters_id"], name: "index_reviews_on_tasters_id"
    t.index ["wines_id"], name: "index_reviews_on_wines_id"
  end

  create_table "tasters", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.string "twitter", limit: 256
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "varieties", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wineries", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "locations_id"
    t.index ["locations_id"], name: "index_wineries_on_locations_id"
  end

  create_table "wines", force: :cascade do |t|
    t.string "name", limit: 256, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wineries_id"
    t.bigint "varieties_id"
    t.bigint "designations_id"
    t.index ["designations_id"], name: "index_wines_on_designations_id"
    t.index ["varieties_id"], name: "index_wines_on_varieties_id"
    t.index ["wineries_id"], name: "index_wines_on_wineries_id"
  end

  add_foreign_key "designations", "wineries", column: "wineries_id"
  add_foreign_key "reviews", "tasters", column: "tasters_id"
  add_foreign_key "reviews", "wines", column: "wines_id"
  add_foreign_key "wineries", "locations", column: "locations_id"
  add_foreign_key "wines", "designations", column: "designations_id"
  add_foreign_key "wines", "varieties", column: "varieties_id"
  add_foreign_key "wines", "wineries", column: "wineries_id"
end
