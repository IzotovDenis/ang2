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

ActiveRecord::Schema.define(version: 20150622053326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.hstore   "log"
    t.string   "controller"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action"
    t.string   "ip"
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "file"
    t.string   "comment"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banners", force: :cascade do |t|
    t.string   "image"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "label"
    t.string   "link"
  end

  create_table "brands", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.float    "actual"
  end

  add_index "currencies", ["name"], name: "index_currencies_on_name", using: :btree

  create_table "ffiles", force: :cascade do |t|
    t.string   "file"
    t.string   "name"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "children_cache"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "cid"
    t.string   "title"
    t.string   "parent_cid"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "site_title"
    t.string   "sort_type",        default: "auto"
    t.boolean  "disabled"
    t.integer  "importsession_id"
    t.datetime "last_new_item"
    t.integer  "items_count",      default: 0
  end

  create_table "imports", force: :cascade do |t|
    t.string   "filename"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "importsession_id"
  end

  create_table "importsessions", force: :cascade do |t|
    t.string   "cookie"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "exchange_type"
  end

  create_table "items", force: :cascade do |t|
    t.string   "cid"
    t.string   "article"
    t.string   "title"
    t.string   "full_title"
    t.string   "group_cid"
    t.integer  "group_id"
    t.string   "image"
    t.hstore   "properties"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qty",              default: 0
    t.integer  "importsession_id"
    t.integer  "position"
    t.string   "brand"
    t.hstore   "label"
    t.string   "certificate"
    t.string   "cross",                                      array: true
    t.jsonb    "bids",             default: {}, null: false
  end

  add_index "items", ["cid"], name: "index_items_on_cid", using: :btree
  add_index "items", ["cross"], name: "index_items_on_cross", using: :btree
  add_index "items", ["group_id"], name: "index_items_on_group_id", using: :btree
  add_index "items", ["properties"], name: "items_properties", using: :gin

  create_table "offers", force: :cascade do |t|
    t.string   "variant"
    t.hstore   "store"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.integer  "qty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",      default: 0.0
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "formed"
    t.text     "comment"
    t.float    "total",      default: 0.0
    t.jsonb    "order_list", default: {}
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pcatalogs", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "position"
    t.boolean  "published",  default: false
    t.string   "block"
    t.string   "url"
  end

  create_table "pricelists", force: :cascade do |t|
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "title"
    t.integer  "pricetype_id"
    t.float    "value"
    t.string   "unit"
    t.string   "cy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["item_id"], name: "index_prices_on_item_id", using: :btree

  create_table "pricetypes", force: :cascade do |t|
    t.string   "cid"
    t.string   "title"
    t.string   "cy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promos", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brand"
    t.integer  "pcatalog_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "currency_id"
    t.float    "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "text"
    t.string   "where"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "result"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "inn"
    t.string   "role",                   default: "user"
    t.string   "person"
    t.string   "city"
    t.string   "name"
    t.string   "legal_address"
    t.string   "actual_address"
    t.string   "kpp"
    t.string   "bank_name"
    t.string   "curr_account"
    t.string   "corr_account"
    t.string   "bik"
    t.string   "phone"
    t.text     "note"
    t.string   "ogrn"
    t.integer  "activities_count",       default: 0
    t.integer  "orders_count",           default: 0
    t.datetime "last_activity_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["inn"], name: "index_users_on_inn", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
