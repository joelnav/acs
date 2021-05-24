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

ActiveRecord::Schema.define(version: 2021_05_24_195136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_connections", force: :cascade do |t|
    t.integer "parent_account_id"
    t.integer "branch_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.integer "balance", default: 0
    t.integer "status", default: 0
    t.string "account_owner_type"
    t.bigint "account_owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_owner_type", "account_owner_id"], name: "index_accounts_on_account_owner"
  end

  create_table "legal_people", force: :cascade do |t|
    t.integer "federal_business_number"
    t.string "company_name"
    t.string "fantasy_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer "social_insurance_number"
    t.string "full_name"
    t.datetime "birth_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_histories", force: :cascade do |t|
    t.integer "account_id"
    t.integer "source_account_id"
    t.integer "amount"
    t.integer "transaction_type"
    t.string "contribution_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "reversible", default: true
  end

end
