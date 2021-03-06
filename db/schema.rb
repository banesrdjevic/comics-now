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

ActiveRecord::Schema.define(version: 20150220002753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sites", force: :cascade do |t|
    t.string   "site_url"
    t.string   "picture_url"
    t.string   "orig_pic_url"
    t.string   "classes"
    t.string   "ids"
    t.string   "container"
    t.string   "domain"
    t.string   "title"
    t.string   "icon_url"
    t.string   "language"
    t.string   "new"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users_sites", force: :cascade do |t|
    t.integer  "users_id"
    t.integer  "sites_id"
    t.string   "favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
