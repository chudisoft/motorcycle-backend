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

ActiveRecord::Schema[7.1].define(version: 2024_02_22_195049) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "motorcycles", force: :cascade do |t|
    t.string "description"
    t.string "color"
    t.string "image"
    t.string "license_plate"
    t.boolean "available", default: true
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "make"
    t.string "model"
    t.date "year"
    t.index ["color"], name: "index_motorcycles_on_color"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "city"
    t.bigint "motorcycle_id", null: false
    t.bigint "user_id", null: false
    t.time "reserve_time"
    t.date "reserve_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["motorcycle_id"], name: "index_reservations_on_motorcycle_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "role"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reservations", "motorcycles"
  add_foreign_key "reservations", "users"
end
