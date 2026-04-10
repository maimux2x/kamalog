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

ActiveRecord::Schema[8.1].define(version: 2026_04_10_074447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clays", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "glazes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "piece_clays", force: :cascade do |t|
    t.bigint "clay_id", null: false
    t.datetime "created_at", null: false
    t.bigint "piece_id", null: false
    t.datetime "updated_at", null: false
    t.integer "weight", null: false
    t.index ["clay_id"], name: "index_piece_clays_on_clay_id"
    t.index ["piece_id"], name: "index_piece_clays_on_piece_id"
  end

  create_table "piece_glazes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "glaze_id", null: false
    t.bigint "piece_id", null: false
    t.datetime "updated_at", null: false
    t.index ["glaze_id"], name: "index_piece_glazes_on_glaze_id"
    t.index ["piece_id"], name: "index_piece_glazes_on_piece_id"
  end

  create_table "pieces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "form_method", null: false
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_pieces_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "piece_clays", "clays"
  add_foreign_key "piece_clays", "pieces"
  add_foreign_key "piece_glazes", "glazes"
  add_foreign_key "piece_glazes", "pieces"
  add_foreign_key "pieces", "users"
end
