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

ActiveRecord::Schema.define(version: 2020_02_10_105646) do

  create_table "events", force: :cascade do |t|
    t.string "competition"
    t.date "scheduled_date"
    t.string "match_team"
    t.string "place"
    t.integer "user_id"
    t.integer "number_applicants"
    t.integer "cost"
    t.text "other_necessary"
    t.text "note"
    t.boolean "cancel_flg", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.string "email"
    t.integer "sex", default: 1, null: false
    t.string "password_digest"
    t.boolean "administrator", default: false, null: false
    t.boolean "delete_flg", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "events", "users"
end
