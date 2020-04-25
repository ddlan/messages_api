# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_22_010004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.integer "user_one_id"
    t.integer "user_two_id"
    t.integer "status_code"
    t.integer "action_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_one_id", "user_two_id"], name: "index_friendships_on_user_one_id_and_user_two_id", unique: true
  end

  create_table "phones", force: :cascade do |t|
    t.bigint "user_id"
    t.string "number"
    t.string "verification_code"
    t.datetime "verification_code_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["number"], name: "index_phones_on_number"
    t.index ["user_id"], name: "index_phones_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "applozic_user_id", limit: 150
    t.string "applozic_access_token"
    t.string "phone_number"
    t.string "email_address"
    t.string "email_verification_code"
    t.boolean "is_email_verified"
    t.string "first_name"
    t.string "last_name"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applozic_access_token"], name: "index_users_on_applozic_access_token", unique: true
    t.index ["applozic_user_id"], name: "index_users_on_applozic_user_id", unique: true
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

end
