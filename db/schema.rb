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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110219001859) do

  create_table "stop_descriptions", :force => true do |t|
    t.integer  "tsn"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "tsndescription"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stop_descriptions", ["latitude"], :name => "index_stop_descriptions_on_latitude"
  add_index "stop_descriptions", ["longitude"], :name => "index_stop_descriptions_on_longitude"
  add_index "stop_descriptions", ["tsn"], :name => "index_stop_descriptions_on_tsn"
  add_index "stop_descriptions", ["tsndescription"], :name => "index_stop_descriptions_on_tsndescription"

  create_table "stops", :force => true do |t|
    t.integer  "tsn"
    t.string   "organisation"
    t.string   "destination"
    t.integer  "vehicleid"
    t.boolean  "realtime"
    t.datetime "arrivaltime"
    t.string   "routename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", :force => true do |t|
    t.integer  "vehicleid"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "tripstatus"
    t.integer  "routedirection"
    t.integer  "routevariant"
    t.string   "routename"
    t.time     "schedule"
    t.string   "servicedescription"
    t.string   "organisation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
