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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121210022830) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dcpls", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "address"
    t.integer  "city_id"
    t.integer  "state_id"
    t.string   "zip_code"
    t.string   "phone"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "order_type_id"
    t.integer  "sample_type_id"
    t.integer  "quantity"
    t.string   "temperature"
    t.string   "urgency"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "order_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "order_type_id"
    t.integer  "quantity"
    t.string   "temperature"
    t.string   "urgency"
    t.integer  "origin_site_id"
    t.integer  "delivery_site_id"
    t.datetime "picked_up_at"
    t.datetime "delivered_at"
    t.string   "tracking_number"
    t.integer  "carrier_id"
    t.integer  "submitted_by_id"
    t.integer  "picked_up_by_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "name"
    t.string   "address_name"
    t.text     "alt_address"
    t.integer  "alt_city_id"
    t.integer  "alt_state_id"
    t.string   "alt_zip_code"
    t.string   "alt_phone"
    t.text     "description"
    t.string   "picked_up_by"
    t.integer  "sample_type_id"
    t.integer  "origin_user_id"
    t.integer  "delivery_user_id"
    t.string   "carrier_name"
    t.string   "area"
    t.text     "comments"
  end

  create_table "sample_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "address"
    t.integer  "city_id"
    t.integer  "state_id"
    t.string   "zip_code"
    t.string   "phone"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "role"
    t.string   "cell_number"
    t.text     "address"
    t.integer  "add_state_id"
    t.integer  "add_city_id"
    t.integer  "zip_code"
  end

end
