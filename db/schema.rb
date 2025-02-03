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

ActiveRecord::Schema[7.2].define(version: 2025_02_03_114056) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.index ["project_id"], name: "index_comments_on_project_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "project_changes", force: :cascade do |t|
    t.string "kind", null: false
    t.string "description", null: false
    t.jsonb "details", default: {}, null: false
    t.datetime "triggered_at", precision: nil, null: false
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_project_changes_on_comment_id"
    t.index ["project_id"], name: "index_project_changes_on_project_id"
    t.index ["user_id"], name: "index_project_changes_on_user_id"
    t.check_constraint "jsonb_typeof(details) = 'object'::text", name: "project_change_details_is_object"
  end

  create_table "project_participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_participations_on_project_id"
    t.index ["user_id"], name: "index_project_participations_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "projects"
  add_foreign_key "comments", "users"
  add_foreign_key "project_changes", "comments"
  add_foreign_key "project_changes", "projects"
  add_foreign_key "project_changes", "users"
  add_foreign_key "project_participations", "projects"
  add_foreign_key "project_participations", "users"
end
