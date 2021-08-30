# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_29_012007) do

  create_table "redirects", force: :cascade do |t|
    t.string "origin", default: ""
    t.string "destination", default: ""
    t.integer "api_id"
    t.integer "shop_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id"], name: "index_redirects_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", default: ""
    t.integer "remote_id"
    t.string "token", default: ""
    t.string "url", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sync_jobs", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "operation", default: 0
    t.integer "api_id"
    t.text "params"
    t.text "sync_errors"
    t.integer "redirect_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["redirect_id"], name: "index_sync_jobs_on_redirect_id"
  end

end
