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

ActiveRecord::Schema.define(version: 20141118144427) do

  create_table "pathways", force: true do |t|
    t.integer  "user_id"
    t.string   "disease"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pathways", ["user_id"], name: "index_pathways_on_user_id"

  create_table "patients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "nhs_number"
  end

  add_index "patients", ["nhs_number"], name: "index_patients_on_nhs_number"

  create_table "treatments", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "pathway_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "treatments", ["pathway_id"], name: "index_treatments_on_pathway_id"

end
