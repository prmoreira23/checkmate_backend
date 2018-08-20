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

ActiveRecord::Schema.define(version: 2018_08_20_122056) do

  create_table "actions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "contract_id"
    t.string "action_type"
    t.string "action_hash"
    t.string "previous_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_actions_on_contract_id"
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipient_id"
    t.text "content"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contract_hash"
    t.string "title"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "job_title"
    t.string "industry"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
