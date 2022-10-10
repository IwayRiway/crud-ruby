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

ActiveRecord::Schema[7.0].define(version: 2022_10_07_012507) do
  create_table "friends", charset: "utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "hp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "functions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.string "name"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_functions_on_menu_id"
  end

  create_table "menus", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "controller"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postingans", charset: "utf8mb4", force: :cascade do |t|
    t.string "judul"
    t.text "deskripsi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_receiving_items", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "product_receiving_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_receiving_items_on_product_id"
    t.index ["product_receiving_id"], name: "index_product_receiving_items_on_product_receiving_id"
  end

  create_table "product_receivings", charset: "utf8mb4", force: :cascade do |t|
    t.string "document_number"
    t.date "document_date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", charset: "utf8mb4", force: :cascade do |t|
    t.string "part_id"
    t.string "part_name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "todo_list_id", null: false
    t.string "name"
    t.boolean "completed"
    t.date "due"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_list_id"], name: "index_tasks_on_todo_list_id"
  end

  create_table "todo_lists", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "functions", "menus"
  add_foreign_key "product_receiving_items", "product_receivings"
  add_foreign_key "product_receiving_items", "products"
  add_foreign_key "tasks", "todo_lists"
end
