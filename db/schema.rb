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

ActiveRecord::Schema.define(version: 20160916132520) do

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
    t.string   "descr"
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
    t.string   "descr"
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
    t.string   "descr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "ws_set_model_runs", ["user_id"], name: "index_ws_set_model_runs_on_user_id", using: :btree

  add_foreign_key "students", "student_groups"
  add_foreign_key "ws_jobs", "users"
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
