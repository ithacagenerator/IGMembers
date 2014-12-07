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

ActiveRecord::Schema.define(version: 20141207000703) do

  create_table "checklist_items", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklist_items_memberships", id: false, force: true do |t|
    t.integer "membership_id",     null: false
    t.integer "checklist_item_id", null: false
  end

  create_table "discounts", force: true do |t|
    t.string   "name"
    t.float    "percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts_memberships", id: false, force: true do |t|
    t.integer "membership_id", null: false
    t.integer "discount_id",   null: false
  end

  create_table "interests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests_members", id: false, force: true do |t|
    t.integer "interest_id", null: false
    t.integer "member_id",   null: false
  end

  create_table "members", force: true do |t|
    t.string   "lname"
    t.string   "fname"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gnucash_id"
    t.date     "birthdate"
    t.string   "parent"
  end

  create_table "membership_types", force: true do |t|
    t.string   "name"
    t.decimal  "monthlycost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "membership_type_id"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.boolean  "paypal",             default: false
  end

  add_index "memberships", ["membership_type_id"], name: "index_memberships_on_membership_type_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.integer  "member_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
