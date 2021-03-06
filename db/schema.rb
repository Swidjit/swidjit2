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

ActiveRecord::Schema.define(version: 20150325000007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer "question_id"
    t.string  "answer"
  end

  create_table "balances", force: true do |t|
    t.integer "user_id"
    t.integer "value"
    t.string  "currency"
  end

  create_table "categories", force: true do |t|
    t.string "name"
    t.string "description"
    t.float  "rate",            default: 0.0
    t.string "category_status"
  end

  create_table "claims", force: true do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.string  "claim_status", default: "submitted"
  end

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", force: true do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.integer "flagged_by"
    t.integer "term"
    t.string  "term_type"
    t.string  "comment"
  end

  create_table "images", force: true do |t|
    t.integer  "item_id"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "invoices", force: true do |t|
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "invoice_status"
    t.float    "value"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.string   "title"
    t.string   "details"
    t.integer  "category_id"
    t.datetime "expiration"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "address"
    t.integer  "importance",     default: 0
    t.string   "publish_status"
    t.string   "condition"
    t.text     "schedule"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "request_id"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.string   "body"
    t.boolean  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_type"
    t.integer  "attachment_id"
  end

  create_table "notifications", force: true do |t|
    t.integer  "item_id"
    t.string   "action"
    t.integer  "importance",   default: 0
    t.integer  "init_user_id"
    t.boolean  "read",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occurrences", force: true do |t|
    t.integer  "item_id"
    t.datetime "dt"
  end

  create_table "offers", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "value"
    t.string   "currency"
    t.string   "message"
    t.datetime "expiration"
  end

  create_table "prices", force: true do |t|
    t.integer "item_id"
    t.string  "currency"
    t.integer "value"
    t.boolean "negotiable"
    t.boolean "digital_payment"
  end

  create_table "reactions", force: true do |t|
    t.string   "reaction_type"
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recurrences", force: true do |t|
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "recur_until"
    t.string   "recurrence_type"
    t.string   "recur_day"
    t.string   "recur_week"
    t.integer  "item_id"
  end

  create_table "requests", force: true do |t|
    t.integer  "user_id"
    t.string   "item_type"
    t.string   "title"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.string   "str"
    t.integer  "val"
    t.boolean  "public",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsvps", force: true do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.integer "rsvp_count", default: 1
    t.string  "rsvp_type"
  end

  create_table "spots", force: true do |t|
    t.integer "item_id"
    t.string  "spot_type"
    t.integer "spot_count"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "subscription_id",   null: false
    t.string   "subscription_type", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "swap_offers", force: true do |t|
    t.text     "productsA",  default: [], array: true
    t.text     "productsB",  default: [], array: true
    t.text     "comment"
    t.integer  "userA_id"
    t.integer  "userB_id"
    t.datetime "expiration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "terms", force: true do |t|
    t.string "title"
    t.string "description"
    t.string "term_type"
  end

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "reason"
    t.integer  "item_id"
    t.integer  "invoice_id"
    t.float    "value"
    t.string   "currency"
    t.string   "transaction_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transfers", force: true do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.integer  "item_id"
    t.integer  "value"
    t.string   "currency"
    t.string   "category"
    t.string   "transfer_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", force: true do |t|
    t.integer "item_id"
    t.string  "title"
    t.text    "description"
    t.string  "image_url"
    t.integer "visit_count", default: 0
    t.string  "url"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "username"
    t.string   "about"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.string   "last_name"
    t.string   "address"
    t.string   "latlng"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "watches", force: true do |t|
    t.integer "item_id"
    t.integer "user_id"
  end

end
