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

ActiveRecord::Schema.define(:version => 20130625213434) do

  create_table "active_admin_comments", :force => true do |t|
    t.string    "resource_id",   :null => false
    t.string    "resource_type", :null => false
    t.integer   "author_id"
    t.string    "author_type"
    t.text      "body"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
    t.string    "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string    "email",                  :default => "", :null => false
    t.string    "encrypted_password",     :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "dealerships", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "dealerships", ["name"], :name => "index_dealerships_on_name", :unique => true

  create_table "exams", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "exams", ["name"], :name => "index_exams_on_name", :unique => true

  create_table "questions", :force => true do |t|
    t.string    "question_text"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
    t.text      "answer1"
    t.text      "answer2"
    t.text      "answer3"
    t.text      "answer4"
    t.integer   "correct"
    t.integer   "section_id"
    t.integer   "order"
  end

  add_index "questions", ["question_text"], :name => "index_questions_on_question_text", :unique => true

  create_table "sections", :force => true do |t|
    t.integer   "order"
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "exam_id"
    t.string    "video_id"
  end

  add_index "sections", ["name"], :name => "index_sections_on_name", :unique => true

  create_table "user_answers", :force => true do |t|
    t.integer   "user_id"
    t.integer   "question_id"
    t.integer   "answer"
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  add_index "user_answers", ["question_id"], :name => "index_user_answers_on_question_id"
  add_index "user_answers", ["user_id"], :name => "index_user_answers_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "remember_token"
    t.integer  "dealership_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "job_title"
    t.integer  "time_taken"
    t.integer  "score"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
