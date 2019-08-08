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

ActiveRecord::Schema.define(version: 20190803092504) do

  create_table "appointments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "entity_status_id"
    t.string "org_name"
    t.string "event_name"
    t.string "venue"
    t.text "details"
    t.date "req_date"
    t.time "req_time"
    t.date "opt_date"
    t.time "opt_time"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_status_id"], name: "index_appointments_on_entity_status_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "beneficiary_schemes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id"
    t.bigint "user_id"
    t.bigint "scheme_type_id"
    t.string "beneficiary_phone"
    t.string "beneficiary_name"
    t.date "application_date"
    t.text "granted_relief"
    t.string "status"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "entity_status_id"
    t.index ["entity_status_id"], name: "index_beneficiary_schemes_on_entity_status_id"
    t.index ["place_id"], name: "index_beneficiary_schemes_on_place_id"
    t.index ["scheme_type_id"], name: "index_beneficiary_schemes_on_scheme_type_id"
    t.index ["user_id"], name: "index_beneficiary_schemes_on_user_id"
  end

  create_table "citizens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "addl_details"
    t.string "pincode"
    t.string "gender"
    t.text "address"
    t.string "email"
    t.string "phone"
    t.string "name"
    t.string "age"
    t.date "dob"
    t.bigint "place_id"
    t.bigint "position_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_citizens_on_phone"
    t.index ["place_id"], name: "index_citizens_on_place_id"
    t.index ["position_id"], name: "index_citizens_on_position_id"
    t.index ["user_id"], name: "index_citizens_on_user_id"
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "development_works", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "department_id"
    t.bigint "place_id"
    t.text "desc", limit: 4294967295
    t.float "estimated_amount", limit: 24
    t.float "sanctioned_amount", limit: 24
    t.date "foundation_date"
    t.date "inaugration_date"
    t.string "status"
    t.string "name"
    t.text "remarks", limit: 4294967295
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "entity_status_id"
    t.integer "valid_type_id"
    t.integer "fy"
    t.index ["department_id"], name: "index_development_works_on_department_id"
    t.index ["entity_status_id"], name: "index_development_works_on_entity_status_id"
    t.index ["place_id"], name: "index_development_works_on_place_id"
  end

  create_table "districts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entity_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "entity_type"
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "typed", default: false
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "details", limit: 4294967295
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.text "venue"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "entity_status_id"
    t.bigint "department_id"
    t.bigint "place_id"
    t.text "details", limit: 4294967295
    t.string "feedback_type"
    t.text "action_taken"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["department_id"], name: "index_feedbacks_on_department_id"
    t.index ["entity_status_id"], name: "index_feedbacks_on_entity_status_id"
    t.index ["place_id"], name: "index_feedbacks_on_place_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "content"
    t.boolean "push"
    t.boolean "mail"
    t.boolean "phone"
    t.date "expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "panchayats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "taluk_id"
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "internal", default: false
    t.index ["taluk_id"], name: "index_panchayats_on_taluk_id"
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "panchayat_id"
    t.string "name"
    t.string "code"
    t.string "place_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.boolean "internal", default: false
    t.index ["panchayat_id"], name: "index_places_on_panchayat_id"
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "pos_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regional_names", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "holder_type"
    t.integer "holder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["holder_id"], name: "index_regional_names_on_holder_id"
  end

  create_table "scheme_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "sub_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stored_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "storage_type"
    t.integer "storage_id"
    t.string "desc"
    t.string "document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stored_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "media_type"
    t.integer "media_id"
    t.string "image"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taluks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "district_id"
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "internal", default: false
    t.index ["district_id"], name: "index_taluks_on_district_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "address"
    t.string "pincode"
    t.string "gender"
    t.string "phone"
    t.string "name"
    t.string "age"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.datetime "access_token_expiry"
    t.string "user_type"
    t.date "dob"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "vid_url"
    t.string "desc"
    t.integer "media_id"
    t.string "media_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "entity_statuses"
  add_foreign_key "appointments", "users"
  add_foreign_key "beneficiary_schemes", "entity_statuses"
  add_foreign_key "beneficiary_schemes", "places"
  add_foreign_key "beneficiary_schemes", "scheme_types"
  add_foreign_key "beneficiary_schemes", "users"
  add_foreign_key "citizens", "places"
  add_foreign_key "citizens", "positions"
  add_foreign_key "citizens", "users"
  add_foreign_key "development_works", "departments"
  add_foreign_key "development_works", "entity_statuses"
  add_foreign_key "development_works", "places"
  add_foreign_key "feedbacks", "departments"
  add_foreign_key "feedbacks", "entity_statuses"
  add_foreign_key "feedbacks", "places"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "panchayats", "taluks"
  add_foreign_key "places", "panchayats"
  add_foreign_key "taluks", "districts"
end
