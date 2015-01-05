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

ActiveRecord::Schema.define(version: 20131129025528) do

  create_table "friends", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_creator",   null: false
    t.integer  "friend_recipient", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lineitems", force: true do |t|
    t.integer  "line_part",                                      null: false
    t.integer  "line_order",                                     null: false
    t.string   "line_name",  limit: 100,                         null: false
    t.decimal  "line_price",             precision: 8, scale: 2, null: false
    t.text     "line_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "order_rest",                                         null: false
    t.integer  "order_organizer",                                    null: false
    t.boolean  "order_type",                                         null: false
    t.decimal  "order_cost",                 precision: 8, scale: 2, null: false
    t.datetime "order_time_at",                                      null: false
    t.string   "order_status",    limit: 20,                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.integer  "part_user",                                     null: false
    t.integer  "part_order",                                    null: false
    t.string   "part_role",  limit: 20,                         null: false
    t.decimal  "part_cost",             precision: 8, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", force: true do |t|
    t.string   "rest_name",       limit: 50,                          null: false
    t.string   "rest_cuisine",    limit: 20,                          null: false
    t.text     "rest_desc"
    t.string   "rest_firstaddr",  limit: 100,                         null: false
    t.string   "rest_secondaddr", limit: 100
    t.string   "rest_city",       limit: 50,                          null: false
    t.string   "rest_state",      limit: 2,                           null: false
    t.string   "rest_zip",        limit: 10,                          null: false
    t.string   "rest_phone",      limit: 20,                          null: false
    t.string   "rest_fax",        limit: 20
    t.string   "rest_url",        limit: 100,                         null: false
    t.boolean  "rest_delivers",                                       null: false
    t.decimal  "rest_fee",                    precision: 8, scale: 2
    t.string   "rest_menufile",   limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_name",       limit: 50, null: false
    t.string   "user_email",      limit: 50, null: false
    t.string   "password_digest", limit: 50, null: false
    t.string   "user_role",       limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
