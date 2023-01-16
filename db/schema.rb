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

ActiveRecord::Schema.define(version: 2023_01_16_160300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "court_id"
    t.date "booking_date"
    t.integer "slot_no"
    t.text "notes"
    t.datetime "booked_at"
    t.datetime "updated_at"
    t.datetime "cancelled_at"
    t.string "cancelled_reason"
  end

  create_table "courts", force: :cascade do |t|
    t.string "name"
    t.integer "type_id"
  end

end
