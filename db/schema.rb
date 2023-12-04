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

ActiveRecord::Schema.define(version: 20160829190645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "channels", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "slack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "channels", ["slack_id"], name: "index_channels_on_slack_id", using: :btree
  add_index "channels", ["team_id"], name: "index_channels_on_team_id", using: :btree

  create_table "data_clips", force: :cascade do |t|
    t.text     "data"
    t.boolean  "starred",        default: false
    t.boolean  "has_urls",       default: false
    t.integer  "user_id"
    t.integer  "channel_id"
    t.json     "slack_response"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "name"
    t.integer  "team_id"
  end

  add_index "data_clips", ["channel_id"], name: "index_data_clips_on_channel_id", using: :btree
  add_index "data_clips", ["team_id"], name: "index_data_clips_on_team_id", using: :btree
  add_index "data_clips", ["user_id"], name: "index_data_clips_on_user_id", using: :btree

  create_table "data_clips_tags", id: false, force: :cascade do |t|
    t.integer "data_clip_id", null: false
    t.integer "tag_id",       null: false
  end

  add_index "data_clips_tags", ["data_clip_id", "tag_id"], name: "index_data_clips_tags_on_data_clip_id_and_tag_id", using: :btree
  add_index "data_clips_tags", ["tag_id", "data_clip_id"], name: "index_data_clips_tags_on_tag_id_and_data_clip_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree
  add_index "tags", ["team_id"], name: "index_tags_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "slack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "domain"
  end

  add_index "teams", ["slack_id"], name: "index_teams_on_slack_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "image"
    t.integer  "team_id"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  add_foreign_key "channels", "teams"
  add_foreign_key "data_clips", "channels"
  add_foreign_key "data_clips", "teams"
  add_foreign_key "data_clips", "users"
  add_foreign_key "tags", "teams"
  add_foreign_key "users", "teams"
end
