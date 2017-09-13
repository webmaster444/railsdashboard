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

ActiveRecord::Schema.define(version: 20170911201052) do

  create_table "maps", force: :cascade do |t|
    t.string "maptitle"
    t.integer "datapoints"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sourcefile"
    t.integer "trait_id"
    t.string "traitgroups_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "traitgroups", force: :cascade do |t|
    t.string "traitgroup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trait_group_name"
  end

  create_table "traits", force: :cascade do |t|
    t.string "trait"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.boolean "user_status"
    t.string "contact"
    t.string "phone"
    t.boolean "caa"
    t.boolean "cua"
    t.boolean "pm"
    t.boolean "vsd"
    t.boolean "eci"
    t.boolean "etp"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
