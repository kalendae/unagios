# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091222230705) do

  create_table "check_logs", :force => true do |t|
    t.integer  "check_id"
    t.integer  "server_id"
    t.boolean  "failed"
    t.text     "output"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checks", :force => true do |t|
    t.text     "execution_code"
    t.text     "check_regex"
    t.integer  "time_between_normal_checks"
    t.integer  "time_between_failed_checks"
    t.integer  "fails_before_notify"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checks_contacts", :force => true do |t|
    t.integer "contact_id"
    t.integer "check_id"
  end

  create_table "checks_servers", :force => true do |t|
    t.integer "server_id"
    t.integer "check_id"
  end

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", :force => true do |t|
    t.string   "nickname"
    t.string   "address"
    t.string   "port"
    t.string   "username"
    t.string   "password"
    t.string   "su_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
