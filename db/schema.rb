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

ActiveRecord::Schema.define(version: 20150915194450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string   "contact_name",  null: false
    t.string   "contact_phone", null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "events", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.string   "street_name"
    t.integer  "street_number"
    t.datetime "next_sweep"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "itineraries", force: :cascade do |t|
    t.string   "cnnrightle"
    t.time     "fromhour"
    t.time     "tohour"
    t.string   "weekday"
    t.string   "streetname"
    t.integer  "lf_fadd"
    t.integer  "lf_toadd"
    t.integer  "rt_fadd"
    t.integer  "rt_toadd"
    t.boolean  "week1ofmon"
    t.boolean  "week2ofmon"
    t.boolean  "week3ofmon"
    t.boolean  "week4ofmon"
    t.boolean  "week5ofmon"
    t.boolean  "holidays"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "phone",      null: false
    t.string   "password",   null: false
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
