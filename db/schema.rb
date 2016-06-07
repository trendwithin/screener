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

ActiveRecord::Schema.define(version: 20160607192921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "all_time_highs", force: :cascade do |t|
    t.string   "symbol",     null: false
    t.datetime "saved_on",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "all_time_highs", ["symbol", "saved_on"], name: "index_all_time_highs_on_symbol_and_saved_on", unique: true, using: :btree

  create_table "daily_high_lows", force: :cascade do |t|
    t.integer  "one_month_high",    null: false
    t.integer  "one_month_low",     null: false
    t.integer  "three_month_high",  null: false
    t.integer  "three_month_low",   null: false
    t.integer  "six_month_high",    null: false
    t.integer  "six_month_low",     null: false
    t.integer  "twelve_month_high", null: false
    t.integer  "twelve_month_low",  null: false
    t.integer  "ytd_high",          null: false
    t.integer  "ytd_low",           null: false
    t.datetime "saved_on",          null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "daily_high_lows", ["saved_on"], name: "index_daily_high_lows_on_saved_on", unique: true, using: :btree

  create_table "new_highs", force: :cascade do |t|
    t.string   "symbol",     null: false
    t.datetime "saved_on",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "new_highs", ["symbol", "saved_on"], name: "index_new_highs_on_symbol_and_saved_on", unique: true, using: :btree

  create_table "zacks", force: :cascade do |t|
    t.string   "symbol",           null: false
    t.string   "company"
    t.string   "report_time"
    t.string   "estimate",         null: false
    t.string   "reported",         null: false
    t.string   "surprise"
    t.string   "current_price"
    t.string   "price_pct_change"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "zacks", ["symbol"], name: "index_zacks_on_symbol", using: :btree

end
