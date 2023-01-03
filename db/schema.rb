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

ActiveRecord::Schema[7.0].define(version: 2022_12_24_211228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mark_survivors", force: :cascade do |t|
    t.bigint "person_report_id"
    t.bigint "person_marked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_marked_id"], name: "index_mark_survivors_on_person_marked_id"
    t.index ["person_report_id", "person_marked_id"], name: "index_mark_survivors_on_person_report_id_and_person_marked_id", unique: true
    t.index ["person_report_id"], name: "index_mark_survivors_on_person_report_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "gender"
    t.string "status", default: "survivor"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "mark_survivors", "people", column: "person_marked_id"
  add_foreign_key "mark_survivors", "people", column: "person_report_id"
end
