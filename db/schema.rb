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

ActiveRecord::Schema[7.0].define(version: 2023_06_17_090524) do
  create_table "apps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "apple_store_details"
    t.string "google_playstore_details"
    t.string "web_url"
    t.bigint "society_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["society_id"], name: "fk_rails_9709a82fe2"
  end

  create_table "apps_join_features", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "app_id"
    t.bigint "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "fk_rails_868b50a13b"
    t.index ["feature_id"], name: "fk_rails_4dff3f163d"
  end

  create_table "apps_join_services", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "app_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "fk_rails_82fcab6f71"
    t.index ["service_id"], name: "fk_rails_b02f7f8563"
  end

  create_table "features", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_published"
    t.index ["name", "service_id"], name: "features_name_service_id_unique_constraint", unique: true
    t.index ["name"], name: "features_name_unique_constraint", unique: true
  end

  create_table "infra_settings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "key"
    t.bigint "parameter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mandatory_apps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "service_id"
    t.boolean "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_published"
    t.index ["name"], name: "mandatory_apps_name_unique_constraint", unique: true
    t.index ["service_id"], name: "fk_rails_c81e08282d"
  end

  create_table "service_cdns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "cdn_hosting_details"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.column "type_of_cdn", "enum('Web','Mobile')", default: "Web"
    t.boolean "is_active"
    t.index ["service_id"], name: "fk_rails_6fc25a1d4f"
  end

  create_table "services", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "github_repo_name"
    t.column "is_mobile_or_web_or_both", "enum('0','1','2','3')", default: "0"
    t.boolean "is_web_published", default: false
    t.boolean "is_app_published", default: false
    t.index ["name"], name: "services_name_unique_constraint", unique: true
  end

  create_table "societies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "aoa_number"
    t.string "logo_s3_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aoa_number"], name: "index_societies_on_aoa_number", unique: true
  end

  create_table "special_cdns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "cdn_hosting_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "apps", "societies"
  add_foreign_key "apps_join_features", "apps"
  add_foreign_key "apps_join_features", "features"
  add_foreign_key "apps_join_services", "apps"
  add_foreign_key "apps_join_services", "services"
  add_foreign_key "mandatory_apps", "services"
  add_foreign_key "service_cdns", "services"
end
