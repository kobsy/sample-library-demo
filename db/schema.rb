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

ActiveRecord::Schema.define(version: 20150306014735) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "isbn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogs", force: :cascade do |t|
    t.integer  "library_id"
    t.integer  "book_id"
    t.integer  "search_count"
    t.integer  "have_now"
    t.integer  "have_total"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "catalogs", ["book_id"], name: "index_catalogs_on_book_id"
  add_index "catalogs", ["library_id"], name: "index_catalogs_on_library_id"

  create_table "libraries", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
