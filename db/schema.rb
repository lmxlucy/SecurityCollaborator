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

ActiveRecord::Schema.define(version: 2021_01_15_184646) do

  create_table "apps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "devices", force: :cascade do |t|
    t.text "q1"
    t.string "q2"
    t.string "q3"
    t.string "q4"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "q5"
    t.string "q6"
    t.boolean "q1_improved"
    t.boolean "q1_improved_2"
    t.boolean "q2_improved"
    t.boolean "q3_improved"
    t.boolean "q4_improved"
    t.boolean "q5_improved"
    t.boolean "q6_improved"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "alerts", default: ""
    t.text "reminders", default: ""
    t.text "device_reminders", default: ""
    t.text "device_alerts", default: ""
    t.date "date"
    t.text "perfect", default: ""
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "user_apps", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "app_id", null: false
    t.string "q1"
    t.string "q2"
    t.string "q3"
    t.string "q4"
    t.string "q5"
    t.text "q6"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "accessed_today"
    t.boolean "q1_improved"
    t.boolean "q2_improved"
    t.boolean "q3_improved"
    t.boolean "q4_improved"
    t.boolean "q5_improved"
    t.boolean "q6_mine_improved"
    t.boolean "q6_partner_improved"
    t.boolean "q6_public_improved"
    t.index ["app_id"], name: "index_user_apps_on_app_id"
    t.index ["user_id"], name: "index_user_apps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "partner_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["partner_id"], name: "index_users_on_partner_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "devices", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "user_apps", "apps"
  add_foreign_key "user_apps", "users"
end
