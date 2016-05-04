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

ActiveRecord::Schema.define(version: 20160504192429) do

  create_table "announcements", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
    t.integer  "user_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "description"
    t.string   "parent_company",         limit: 255
    t.string   "url",                    limit: 255
    t.string   "slug",                   limit: 255
    t.date     "claim_date"
    t.integer  "period_id"
    t.date     "founding_date"
    t.integer  "membership_size_id"
    t.integer  "parent_organization_id"
  end

  create_table "boards_categories", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "board_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "forr",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_events", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "event_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
    t.integer  "user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.text     "description"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "location",         limit: 255
    t.string   "location_address", limit: 255
    t.string   "event_url",        limit: 255
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",             limit: 255
  end

  create_table "membership_sizes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parent_organizations", force: :cascade do |t|
    t.string   "ein",        limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "periods", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviewer_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "pros"
    t.text     "cons"
    t.float    "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id"
    t.integer  "reviewer_type_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.string   "suggester_email",      limit: 255
    t.string   "suggested_board_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "admin",                              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vendor_reviews", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.float    "rating"
    t.text     "pros"
    t.text     "cons"
    t.integer  "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "address",     limit: 255
    t.string   "phone",       limit: 255
    t.string   "email",       limit: 255
    t.string   "contact",     limit: 255
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "outdoor"
    t.boolean  "indoor"
    t.string   "capacity"
    t.string   "cost"
    t.boolean  "food"
    t.boolean  "catering"
    t.string   "website_url"
  end

end
