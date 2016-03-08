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

ActiveRecord::Schema.define(version: 20160308105912) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_modules", force: true do |t|
    t.text     "data"
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "data_modules", ["subcategory_id"], name: "index_data_modules_on_subcategory_id"

  create_table "doctors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.boolean  "superuser"
    t.string   "contact_details"
  end

  add_index "doctors", ["email"], name: "index_doctors_on_email", unique: true
  add_index "doctors", ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true

  create_table "doctors_teams", id: false, force: true do |t|
    t.integer "team_id",   null: false
    t.integer "doctor_id", null: false
  end

  add_index "doctors_teams", ["doctor_id"], name: "index_doctors_teams_on_doctor_id"
  add_index "doctors_teams", ["team_id"], name: "index_doctors_teams_on_team_id"

  create_table "images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "pathways", force: true do |t|
    t.integer  "patient_id"
    t.string   "disease"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pathways", ["patient_id"], name: "index_pathways_on_patient_id"

  create_table "patients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "nhs_number"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "patients", ["email"], name: "index_patients_on_email"
  add_index "patients", ["nhs_number"], name: "index_patients_on_nhs_number"
  add_index "patients", ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true

  create_table "patients_teams", id: false, force: true do |t|
    t.integer "team_id",    null: false
    t.integer "patient_id", null: false
  end

  add_index "patients_teams", ["patient_id"], name: "index_patients_teams_on_patient_id"
  add_index "patients_teams", ["team_id"], name: "index_patients_teams_on_team_id"

  create_table "rich_rich_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
  end

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id"

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatment_modules", force: true do |t|
    t.integer  "treatment_state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "data_module_id"
  end

  add_index "treatment_modules", ["treatment_state_id"], name: "index_treatment_modules_on_treatment_state_id"

  create_table "treatment_states", force: true do |t|
    t.string   "timeframe"
    t.integer  "pathway_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default"
    t.date     "assigned_date"
  end

  add_index "treatment_states", ["pathway_id"], name: "index_treatment_states_on_pathway_id"

end
