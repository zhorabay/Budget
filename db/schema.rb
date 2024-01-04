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

ActiveRecord::Schema[7.1].define(version: 2024_01_04_111458) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_categories_on_author_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "name"
    t.decimal "amount"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_transactions_on_author_id"
  end

  create_table "transactions_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "transaction_reference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_transactions_categories_on_category_id"
    t.index ["transaction_reference_id"], name: "index_transactions_categories_on_transaction_reference_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "categories", "users", column: "author_id"
  add_foreign_key "transactions", "users", column: "author_id"
  add_foreign_key "transactions_categories", "categories"
  add_foreign_key "transactions_categories", "transactions", column: "transaction_reference_id"
end
