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

ActiveRecord::Schema[8.1].define(version: 2026_11_06_083934) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "clay_usages", force: :cascade do |t|
    t.integer "piece_id", null: false
    t.integer "clay_id", null: false
    t.float "weight_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight_unit", null: false
    t.index ["clay_id"], name: "index_clay_usages_on_clay_id"
    t.index ["piece_id"], name: "index_clay_usages_on_piece_id"
  end

  create_table "clays", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "studio_id", null: false
    t.integer "position", null: false
    t.index ["studio_id", "name"], name: "index_clays_on_studio_id_and_name", unique: true
    t.index ["studio_id", "position"], name: "index_clays_on_studio_id_and_position", unique: true
    t.index ["studio_id"], name: "index_clays_on_studio_id"
  end

  create_table "glaze_usages", force: :cascade do |t|
    t.integer "piece_id", null: false
    t.integer "glaze_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["glaze_id"], name: "index_glaze_usages_on_glaze_id"
    t.index ["piece_id", "glaze_id"], name: "index_glaze_usages_on_piece_id_and_glaze_id", unique: true
    t.index ["piece_id"], name: "index_glaze_usages_on_piece_id"
  end

  create_table "glazes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "studio_id", null: false
    t.integer "position", null: false
    t.index ["studio_id", "name"], name: "index_glazes_on_studio_id_and_name", unique: true
    t.index ["studio_id", "position"], name: "index_glazes_on_studio_id_and_position", unique: true
    t.index ["studio_id"], name: "index_glazes_on_studio_id"
  end

  create_table "logs", force: :cascade do |t|
    t.integer "piece_id", null: false
    t.date "date", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["piece_id"], name: "index_logs_on_piece_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "studio_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id"], name: "index_memberships_on_studio_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "log_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "caption"
    t.integer "position", null: false
    t.index ["log_id", "position"], name: "index_photos_on_log_id_and_position", unique: true
    t.index ["log_id"], name: "index_photos_on_log_id"
  end

  create_table "pieces", force: :cascade do |t|
    t.string "title", null: false
    t.integer "status", default: 0, null: false
    t.integer "form_method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "membership_id", null: false
    t.datetime "completed_at"
    t.index ["membership_id"], name: "index_pieces_on_membership_id"
  end

  create_table "step_kinds", force: :cascade do |t|
    t.integer "studio_id", null: false
    t.string "name", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["studio_id", "position"], name: "index_step_kinds_on_studio_id_and_position", unique: true
    t.index ["studio_id"], name: "index_step_kinds_on_studio_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "log_id", null: false
    t.integer "kind_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind_id"], name: "index_steps_on_kind_id"
    t.index ["log_id"], name: "index_steps_on_log_id"
  end

  create_table "studios", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.index ["invitation_token"], name: "index_studios_on_invitation_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_seen_studio_id"
    t.index ["last_seen_studio_id"], name: "index_users_on_last_seen_studio_id"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clay_usages", "clays"
  add_foreign_key "clay_usages", "pieces"
  add_foreign_key "clays", "studios"
  add_foreign_key "glaze_usages", "glazes"
  add_foreign_key "glaze_usages", "pieces"
  add_foreign_key "glazes", "studios"
  add_foreign_key "logs", "pieces"
  add_foreign_key "memberships", "studios"
  add_foreign_key "memberships", "users"
  add_foreign_key "photos", "logs"
  add_foreign_key "pieces", "memberships"
  add_foreign_key "step_kinds", "studios"
  add_foreign_key "steps", "logs"
  add_foreign_key "steps", "step_kinds", column: "kind_id"
  add_foreign_key "users", "studios", column: "last_seen_studio_id"
end
