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

ActiveRecord::Schema.define(version: 20130828083807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    default: false
  end

  create_table "conversations_users", force: true do |t|
    t.integer "user_id"
    t.integer "conversation_id"
  end

  create_table "countries", id: false, force: true do |t|
    t.string  "iso_2letters", limit: 2, null: false
    t.string  "ascii_name"
    t.integer "geo_id"
  end

  add_index "countries", ["geo_id"], name: "index_countries_on_geo_id", unique: true, using: :btree

  create_table "group_tags", force: true do |t|
    t.integer "group_id"
    t.integer "tag_id"
    t.integer "hits"
  end

  add_index "group_tags", ["group_id"], name: "index_group_tags_on_group_id", using: :btree
  add_index "group_tags", ["tag_id"], name: "index_group_tags_on_tag_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "creator_user_id"
    t.text     "motd"
    t.boolean  "public",              default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "groups", ["description"], name: "index_groups_on_description", using: :btree
  add_index "groups", ["name"], name: "index_groups_on_name", using: :btree

  create_table "groups_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "is_admin",     default: false
    t.boolean  "is_moderator", default: false
    t.boolean  "read_only",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_users", ["group_id"], name: "index_groups_users_on_group_id", using: :btree
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id", using: :btree

  create_table "groups_walls", force: true do |t|
    t.integer  "wall_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_walls", ["group_id"], name: "index_groups_walls_on_group_id", using: :btree
  add_index "groups_walls", ["wall_id"], name: "index_groups_walls_on_wall_id", using: :btree

  create_table "interest_tags", force: true do |t|
    t.integer "interest_id"
    t.integer "tag_id"
    t.integer "hits"
  end

  add_index "interest_tags", ["interest_id"], name: "index_interest_tags_on_interest_id", using: :btree
  add_index "interest_tags", ["tag_id"], name: "index_interest_tags_on_tag_id", using: :btree

  create_table "interests", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "interests_walls", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_names", force: true do |t|
    t.string  "lang"
    t.integer "geo_id"
    t.string  "name"
  end

  add_index "location_names", ["geo_id"], name: "index_location_names_on_geo_id", using: :btree
  add_index "location_names", ["lang"], name: "index_location_names_on_lang", using: :btree

  create_table "locations", id: false, force: true do |t|
    t.integer "geo_id",               null: false
    t.string  "ascii_name"
    t.float   "latitude"
    t.float   "longtitude"
    t.string  "country",    limit: 2
  end

  add_index "locations", ["country"], name: "index_locations_on_country", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "post_date"
    t.boolean  "is_read"
    t.text     "message_text"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["post_date"], name: "index_messages_on_post_date", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "tag"
    t.integer  "hits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag", using: :btree

  create_table "user_interests", force: true do |t|
    t.integer "user_id"
    t.integer "interest_id"
    t.boolean "is_consumer", default: true
  end

  add_index "user_interests", ["interest_id"], name: "index_user_interests_on_interest_id", using: :btree
  add_index "user_interests", ["user_id"], name: "index_user_interests_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "registration_date"
    t.boolean  "registered"
    t.datetime "last_online_date"
    t.float    "range"
    t.boolean  "deleted"
    t.datetime "delete_date"
    t.string   "skype"
    t.boolean  "email_public"
    t.string   "jabber"
    t.string   "location_name"
    t.boolean  "site_admin"
    t.boolean  "banned"
    t.datetime "ban_date"
    t.datetime "banned_till"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.date     "birth_date"
    t.boolean  "is_age_visible"
    t.text     "description"
  end

  create_table "users_walls", force: true do |t|
    t.integer  "user_id"
    t.integer  "wall_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_walls", ["user_id"], name: "index_users_walls_on_user_id", using: :btree
  add_index "users_walls", ["wall_id"], name: "index_users_walls_on_wall_id", using: :btree

  create_table "wall_messages", force: true do |t|
    t.integer  "wall_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wall_messages", ["user_id"], name: "index_wall_messages_on_user_id", using: :btree
  add_index "wall_messages", ["wall_id"], name: "index_wall_messages_on_wall_id", using: :btree

  create_table "walls", force: true do |t|
    t.boolean  "is_readonly", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
