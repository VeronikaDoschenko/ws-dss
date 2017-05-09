# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170503042910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "descriptions", force: :cascade do |t|
    t.string   "descr"
    t.string   "locale"
    t.integer  "rec_id"
    t.string   "rec_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "documents_subjects", id: false, force: :cascade do |t|
    t.integer "document_id", null: false
    t.integer "subject_id",  null: false
  end

  add_index "documents_subjects", ["subject_id", "document_id"], name: "index_documents_subjects_on_subject_id_and_document_id", using: :btree

  create_table "refinery_image_translations", force: :cascade do |t|
    t.integer  "refinery_image_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "image_alt"
    t.string   "image_title"
  end

  add_index "refinery_image_translations", ["locale"], name: "index_refinery_image_translations_on_locale", using: :btree
  add_index "refinery_image_translations", ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id", using: :btree

  create_table "refinery_images", force: :cascade do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_title"
    t.string   "image_alt"
  end

  create_table "refinery_inquiries_inquiries", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.boolean  "spam",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_inquiries_inquiries", ["id"], name: "index_refinery_inquiries_inquiries_on_id", using: :btree

  create_table "refinery_page_part_translations", force: :cascade do |t|
    t.integer  "refinery_page_part_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "body"
  end

  add_index "refinery_page_part_translations", ["locale"], name: "index_refinery_page_part_translations_on_locale", using: :btree
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id", using: :btree

  create_table "refinery_page_parts", force: :cascade do |t|
    t.integer  "refinery_page_id"
    t.string   "slug"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "refinery_page_parts", ["id"], name: "index_refinery_page_parts_on_id", using: :btree
  add_index "refinery_page_parts", ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id", using: :btree

  create_table "refinery_page_translations", force: :cascade do |t|
    t.integer  "refinery_page_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
  end

  add_index "refinery_page_translations", ["locale"], name: "index_refinery_page_translations_on_locale", using: :btree
  add_index "refinery_page_translations", ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id", using: :btree

  create_table "refinery_pages", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.string   "custom_slug"
    t.boolean  "show_in_menu",        default: true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           default: true
    t.boolean  "draft",               default: false
    t.boolean  "skip_to_first_child", default: false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_pages", ["depth"], name: "index_refinery_pages_on_depth", using: :btree
  add_index "refinery_pages", ["id"], name: "index_refinery_pages_on_id", using: :btree
  add_index "refinery_pages", ["lft"], name: "index_refinery_pages_on_lft", using: :btree
  add_index "refinery_pages", ["parent_id"], name: "index_refinery_pages_on_parent_id", using: :btree
  add_index "refinery_pages", ["rgt"], name: "index_refinery_pages_on_rgt", using: :btree

  create_table "refinery_resource_translations", force: :cascade do |t|
    t.integer  "refinery_resource_id", null: false
    t.string   "locale",               null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "resource_title"
  end

  add_index "refinery_resource_translations", ["locale"], name: "index_refinery_resource_translations_on_locale", using: :btree
  add_index "refinery_resource_translations", ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id", using: :btree

  create_table "refinery_resources", force: :cascade do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_settings", force: :cascade do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable",     default: true
    t.string   "scoping"
    t.boolean  "restricted",      default: false
    t.string   "form_value_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "title"
  end

  add_index "refinery_settings", ["name"], name: "index_refinery_settings_on_name", using: :btree

  create_table "royce_connector", force: :cascade do |t|
    t.integer  "roleable_id",   null: false
    t.string   "roleable_type", null: false
    t.integer  "role_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "royce_connector", ["role_id"], name: "index_royce_connector_on_role_id", using: :btree
  add_index "royce_connector", ["roleable_id", "roleable_type"], name: "index_royce_connector_on_roleable_id_and_roleable_type", using: :btree

  create_table "royce_role", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "royce_role", ["name"], name: "index_royce_role_on_name", using: :btree

  create_table "seo_meta", force: :cascade do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.text     "meta_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "seo_meta", ["id"], name: "index_seo_meta_on_id", using: :btree
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta", using: :btree

  create_table "student_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "mname"
    t.string   "lname"
    t.string   "serial"
    t.string   "email"
    t.integer  "student_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "translations", force: :cascade do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.integer  "numjobs",                default: 10, null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "ws_jobs", force: :cascade do |t|
    t.text     "input"
    t.text     "output"
    t.integer  "ws_method_id",              null: false
    t.integer  "user_id",                   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "error_code",    default: 0, null: false
    t.integer  "for_check",     default: 0, null: false
    t.integer  "do_check",      default: 0, null: false
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.string   "output_data"
  end

# Could not dump table "ws_methods" because of following StandardError
#   Unknown type 'format_type' for column 'format_output'

  create_table "ws_model_runs", force: :cascade do |t|
    t.string   "name"
    t.integer  "ws_model_id"
    t.integer  "ws_model_status_id"
    t.text     "trace"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.string   "descr"
    t.integer  "ws_set_model_run_id"
    t.integer  "target_ws_model_id"
    t.integer  "goal_ws_param_value_id"
  end

  add_index "ws_model_runs", ["goal_ws_param_value_id"], name: "index_ws_model_runs_on_goal_ws_param_value_id", using: :btree
  add_index "ws_model_runs", ["target_ws_model_id"], name: "index_ws_model_runs_on_target_ws_model_id", using: :btree
  add_index "ws_model_runs", ["user_id"], name: "index_ws_model_runs_on_user_id", using: :btree
  add_index "ws_model_runs", ["ws_model_id"], name: "index_ws_model_runs_on_ws_model_id", using: :btree
  add_index "ws_model_runs", ["ws_model_status_id"], name: "index_ws_model_runs_on_ws_model_status_id", using: :btree
  add_index "ws_model_runs", ["ws_set_model_run_id"], name: "index_ws_model_runs_on_ws_set_model_run_id", using: :btree

  create_table "ws_model_runs_set_model_runs", force: :cascade do |t|
    t.integer "ws_model_run_id",     null: false
    t.integer "ws_set_model_run_id", null: false
    t.integer "ord"
  end

  add_index "ws_model_runs_set_model_runs", ["ws_set_model_run_id", "ws_model_run_id"], name: "index_set_model_run_link", using: :btree

  create_table "ws_model_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ws_models", force: :cascade do |t|
    t.string   "name"
    t.string   "model_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.integer  "ws_method_id"
  end

  add_index "ws_models", ["user_id"], name: "index_ws_models_on_user_id", using: :btree
  add_index "ws_models", ["ws_method_id"], name: "index_ws_models_on_ws_method_id", using: :btree

  create_table "ws_param_models", force: :cascade do |t|
    t.integer  "ws_model_id"
    t.integer  "ws_param_id"
    t.boolean  "is_required"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "is_copy"
  end

  add_index "ws_param_models", ["ws_model_id"], name: "index_ws_param_models_on_ws_model_id", using: :btree
  add_index "ws_param_models", ["ws_param_id", "ws_model_id"], name: "index_ws_param_models_on_ws_param_id_and_ws_model_id", unique: true, using: :btree
  add_index "ws_param_models", ["ws_param_id"], name: "index_ws_param_models_on_ws_param_id", using: :btree

  create_table "ws_param_values", force: :cascade do |t|
    t.integer  "ws_param_id"
    t.integer  "ws_model_run_id"
    t.string   "old_value"
    t.string   "new_value"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "ws_set_model_run_id"
    t.string   "formula"
  end

  add_index "ws_param_values", ["ws_model_run_id"], name: "index_ws_param_values_on_ws_model_run_id", using: :btree
  add_index "ws_param_values", ["ws_param_id", "ws_model_run_id"], name: "index_ws_param_values_on_ws_param_id_and_ws_model_run_id", unique: true, using: :btree
  add_index "ws_param_values", ["ws_param_id"], name: "index_ws_param_values_on_ws_param_id", using: :btree
  add_index "ws_param_values", ["ws_set_model_run_id"], name: "index_ws_param_values_on_ws_set_model_run_id", using: :btree

  create_table "ws_param_values_params", force: :cascade do |t|
    t.integer "ws_param_id",       null: false
    t.integer "ws_param_value_id", null: false
    t.integer "ord"
  end

  add_index "ws_param_values_params", ["ws_param_value_id", "ws_param_id"], name: "index_param_value_source_link", using: :btree

  create_table "ws_params", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_int"
    t.integer  "dim",        default: 0
    t.decimal  "min_val"
    t.decimal  "max_val"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
  end

  add_index "ws_params", ["user_id"], name: "index_ws_params_on_user_id", using: :btree

  create_table "ws_set_model_runs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "ws_set_model_runs", ["user_id"], name: "index_ws_set_model_runs_on_user_id", using: :btree

  add_foreign_key "students", "student_groups"
  add_foreign_key "ws_jobs", "users"
  add_foreign_key "ws_jobs", "users"
  add_foreign_key "ws_jobs", "ws_methods"
  add_foreign_key "ws_jobs", "ws_methods"
  add_foreign_key "ws_model_runs", "users"
  add_foreign_key "ws_model_runs", "ws_model_statuses"
  add_foreign_key "ws_model_runs", "ws_models"
  add_foreign_key "ws_model_runs", "ws_models", column: "target_ws_model_id"
  add_foreign_key "ws_model_runs", "ws_param_values", column: "goal_ws_param_value_id"
  add_foreign_key "ws_model_runs", "ws_set_model_runs"
  add_foreign_key "ws_models", "users"
  add_foreign_key "ws_models", "ws_methods"
  add_foreign_key "ws_param_models", "ws_models"
  add_foreign_key "ws_param_models", "ws_params"
  add_foreign_key "ws_param_values", "ws_model_runs"
  add_foreign_key "ws_param_values", "ws_params"
  add_foreign_key "ws_param_values", "ws_set_model_runs"
  add_foreign_key "ws_params", "users"
  add_foreign_key "ws_set_model_runs", "users"
end
