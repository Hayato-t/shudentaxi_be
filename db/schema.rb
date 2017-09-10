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

ActiveRecord::Schema.define(version: 20170910204441) do

  create_table "feelings", force: :cascade do |t|
    t.integer "userid"
    t.decimal "comment_lat"
    t.decimal "comment_lng"
    t.string "comment_body"
    t.string "comment_imgpath"
    t.integer "like", default: 0
    t.integer "fight", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matchedgroups", force: :cascade do |t|
    t.integer "userid1"
    t.integer "userid2"
    t.integer "userid3"
    t.string "taxi_number"
    t.decimal "taxi_lat"
    t.decimal "taxi_lng"
    t.decimal "obj_lat"
    t.decimal "obj_lng"
    t.integer "report"
    t.integer "members"
    t.integer "closed_flag"
    t.integer "delete_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matchings", force: :cascade do |t|
    t.integer "userid"
    t.decimal "here_lat"
    t.decimal "here_lng"
    t.decimal "obj_lat"
    t.decimal "obj_lng"
    t.integer "paired_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxiallotments", force: :cascade do |t|
    t.decimal "lat"
    t.decimal "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "userid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
