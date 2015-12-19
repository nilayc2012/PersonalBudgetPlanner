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

ActiveRecord::Schema.define(version: 20150629094913) do

  create_table "expenses", force: true do |t|
    t.string   "expense_type"
    t.decimal  "expense_amount"
    t.date     "expense_date"
    t.text     "expense_desc"
    t.string   "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "username"
    t.string   "notify_string"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date"
    t.date     "date1"
  end

  create_table "shared_expenses", force: true do |t|
    t.integer  "expense_id"
    t.string   "expense_type"
    t.decimal  "expense_amount"
    t.date     "expense_date"
    t.text     "expense_desc"
    t.string   "user_name"
    t.string   "shared_user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_details", force: true do |t|
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
  end

end
