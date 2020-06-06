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

ActiveRecord::Schema.define(version: 2020_05_31_203520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "ip_address_ranges", force: :cascade do |t|
    t.bigint "country_id"
    t.inet "start_ip"
    t.inet "end_ip"
    t.inet "mask"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["count"], name: "index_ip_address_ranges_on_count"
    t.index ["country_id", "start_ip", "end_ip"], name: "index_ip_address_ranges_on_country_id_and_start_ip_and_end_ip", unique: true
    t.index ["country_id"], name: "index_ip_address_ranges_on_country_id"
    t.index ["end_ip"], name: "index_ip_address_ranges_on_end_ip"
    t.index ["mask"], name: "index_ip_address_ranges_on_mask"
    t.index ["start_ip"], name: "index_ip_address_ranges_on_start_ip"
  end

end
