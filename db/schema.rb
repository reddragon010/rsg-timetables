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

ActiveRecord::Schema.define(:version => 20101220155937) do

  create_table "entries", :force => true do |t|
    t.string   "schoolday"
    t.integer  "lession"
    t.integer  "subject_id"
    t.integer  "klass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries_rooms", :id => false, :force => true do |t|
    t.integer "entry_id"
    t.integer "room_id"
  end

  create_table "entries_teachers", :id => false, :force => true do |t|
    t.integer "entry_id"
    t.integer "teacher_id"
  end

  create_table "klasses", :force => true do |t|
    t.string   "short"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.string   "short"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string   "short"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "teachers", :force => true do |t|
    t.string   "short"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
