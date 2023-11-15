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

ActiveRecord::Schema[7.1].define(version: 2023_11_15_161707) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "documents", force: :cascade do |t|
    t.text "description"
    t.integer "syze_in_bytes"
    t.integer "kind"
    t.string "documentable_type", null: false
    t.bigint "documentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable"
  end

  create_table "payloads", force: :cascade do |t|
    t.string "name"
    t.string "weight"
    t.text "description"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.integer "earth_distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rocket_data", force: :cascade do |t|
    t.bigint "rocket_id", null: false
    t.bigint "payload_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payload_id"], name: "index_rocket_data_on_payload_id"
    t.index ["rocket_id"], name: "index_rocket_data_on_rocket_id"
  end

  create_table "space_agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "space_shuttle_data", force: :cascade do |t|
    t.bigint "space_shuttle_id", null: false
    t.integer "max_crew_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_shuttle_id"], name: "index_space_shuttle_data_on_space_shuttle_id"
  end

  create_table "spacecrafts", force: :cascade do |t|
    t.string "name"
    t.integer "velocity"
    t.bigint "space_agency_id", null: false
    t.integer "fuel_in_days"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_agency_id"], name: "index_spacecrafts_on_space_agency_id"
  end

  create_table "travels", force: :cascade do |t|
    t.date "beginning_date"
    t.integer "duration"
    t.bigint "planet_id", null: false
    t.bigint "spacecraft_id", null: false
    t.text "description"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_travels_on_planet_id"
    t.index ["spacecraft_id"], name: "index_travels_on_spacecraft_id"
  end

  create_table "ufo_data", force: :cascade do |t|
    t.integer "max_crew_size"
    t.bigint "ufo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ufo_id"], name: "index_ufo_data_on_ufo_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "rocket_data", "payloads"
  add_foreign_key "rocket_data", "spacecrafts", column: "rocket_id"
  add_foreign_key "space_shuttle_data", "spacecrafts", column: "space_shuttle_id"
  add_foreign_key "spacecrafts", "space_agencies"
  add_foreign_key "travels", "planets"
  add_foreign_key "travels", "spacecrafts"
  add_foreign_key "ufo_data", "spacecrafts", column: "ufo_id"
end
