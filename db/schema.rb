# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150604193740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.integer  "lottery_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "ticket_id"
  end

  add_index "awards", ["ticket_id"], name: "index_awards_on_ticket_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "company_name", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "key",          null: false
  end

  create_table "contactforms", force: :cascade do |t|
    t.string   "name"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "email"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
  end

  create_table "lotteries", force: :cascade do |t|
    t.string   "lottery_name"
    t.datetime "start_date"
    t.integer  "number_of_tickets"
    t.decimal  "price_per_ticket"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "company_id"
    t.boolean  "finished",          default: false, null: false
  end

  add_index "lotteries", ["company_id"], name: "index_lotteries_on_company_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer  "lottery_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "won"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                   default: "user", null: false
    t.string   "email"
    t.integer  "credits"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "company_id"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "awards", "tickets"
  add_foreign_key "lotteries", "companies"
  add_foreign_key "users", "companies"
end
