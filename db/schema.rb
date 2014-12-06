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

ActiveRecord::Schema.define(version: 20141122142847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "problems", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pass_count",   default: 0
    t.integer  "submit_count", default: 0
    t.string   "abbr"
  end

  create_table "submits", force: true do |t|
    t.integer  "problem_id"
    t.integer  "status",        default: 0
    t.integer  "memory"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "code"
    t.integer  "language"
    t.text     "compiler_info"
    t.integer  "score"
  end

  create_table "test_files", force: true do |t|
    t.integer  "problem_id"
    t.integer  "data",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: true do |t|
    t.integer  "submit_id"
    t.integer  "status"
    t.integer  "memory"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
