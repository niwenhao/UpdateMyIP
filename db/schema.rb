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

ActiveRecord::Schema.define(version: 20170530013551) do

  create_table "host_addresses", force: :cascade do |t|
    t.string "hostname", limit: 30
    t.string "ip", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secret", limit: 70
    t.index ["hostname"], name: "index_host_addresses_on_hostname", unique: true
  end

end
