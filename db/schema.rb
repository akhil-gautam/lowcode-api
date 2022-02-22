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

ActiveRecord::Schema.define(version: 2022_02_15_143739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "apps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.uuid "user_id", null: false
    t.uuid "data_source_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at", precision: 6
    t.index ["data_source_id"], name: "index_apps_on_data_source_id"
    t.index ["deleted_at"], name: "index_apps_on_deleted_at"
    t.index ["user_id"], name: "index_apps_on_user_id"
  end

  create_table "components", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "heading"
    t.integer "component_order"
    t.integer "component_type"
    t.text "component_query"
    t.uuid "page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "settings", default: {}
    t.datetime "deleted_at", precision: 6
    t.index ["deleted_at"], name: "index_components_on_deleted_at"
    t.index ["page_id"], name: "index_components_on_page_id"
  end

  create_table "data_sources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "source"
    t.jsonb "settings"
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_data_sources_on_user_id"
  end

  create_table "form_elements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "label"
    t.uuid "form_id", null: false
    t.integer "field_order", null: false
    t.string "field_type", null: false
    t.boolean "required"
    t.jsonb "settings"
    t.string "db_column", null: false
    t.string "helper_text"
    t.string "placeholder", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_form_elements_on_form_id"
  end

  create_table "forms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.uuid "app_id", null: false
    t.integer "status"
    t.text "form_query"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at", precision: 6
    t.index ["app_id"], name: "index_forms_on_app_id"
    t.index ["deleted_at"], name: "index_forms_on_deleted_at"
  end

  create_table "pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.integer "page_order"
    t.uuid "app_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at", precision: 6
    t.index ["app_id"], name: "index_pages_on_app_id"
    t.index ["deleted_at"], name: "index_pages_on_deleted_at"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "apps", "data_sources"
  add_foreign_key "apps", "users"
  add_foreign_key "components", "pages"
  add_foreign_key "data_sources", "users"
  add_foreign_key "form_elements", "forms"
  add_foreign_key "forms", "apps"
  add_foreign_key "pages", "apps"
end