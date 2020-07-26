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

ActiveRecord::Schema.define(version: 2020_07_25_131949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "api_keys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "token"
    t.boolean "active", default: true
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_api_keys_on_token", unique: true
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "ip_address_ranges", force: :cascade do |t|
    t.bigint "location_id"
    t.string "start_ip"
    t.string "end_ip"
    t.bigint "start_int"
    t.bigint "end_int"
    t.integer "mask"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_int"], name: "index_ip_address_ranges_on_end_int"
    t.index ["location_id"], name: "index_ip_address_ranges_on_location_id"
    t.index ["start_int"], name: "index_ip_address_ranges_on_start_int"
    t.index ["start_ip", "end_ip"], name: "index_ip_address_ranges_on_start_ip_and_end_ip", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "country"
    t.string "abbreviation"
    t.string "region"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country", "abbreviation", "region", "city"], name: "index_locations_on_country_and_abbreviation_and_region_and_city", unique: true
  end

  create_table "requests", force: :cascade do |t|
    t.string "request"
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.string "password_reset_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmed_at"], name: "index_users_on_confirmed_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
