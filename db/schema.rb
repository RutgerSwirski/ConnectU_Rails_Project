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

ActiveRecord::Schema.define(version: 2019_04_09_132840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "address"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "total_tickets"
    t.integer "available_tickets"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "activity_photos", force: :cascade do |t|
    t.string "photo", default: "jgzmvpaumlt326d8fcal.jpg"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_photos_on_activity_id"
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.integer "quantity"
    t.bigint "flat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_amenities_on_flat_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "activity_id"
    t.bigint "flat_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_favourites_on_activity_id"
    t.index ["flat_id"], name: "index_favourites_on_flat_id"
    t.index ["trip_id"], name: "index_favourites_on_trip_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "flat_photos", force: :cascade do |t|
    t.string "photo", default: "l7i9qo6gxliuk2s4hazi.jpg"
    t.bigint "flat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_flat_photos_on_flat_id"
  end

  create_table "flats", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_flats_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.string "status"
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_friends_on_recipient_id"
    t.index ["sender_id"], name: "index_friends_on_sender_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_messages_on_recipient_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.jsonb "payment"
    t.bigint "user_id"
    t.bigint "trip_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flat_id"
    t.date "flat_booked_start"
    t.date "flat_booked_end"
    t.integer "number_of_orders"
    t.integer "number_of_guests"
    t.index ["activity_id"], name: "index_orders_on_activity_id"
    t.index ["flat_id"], name: "index_orders_on_flat_id"
    t.index ["trip_id"], name: "index_orders_on_trip_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "review_content"
    t.integer "rating"
    t.bigint "user_id"
    t.bigint "trip_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flat_id"
    t.index ["activity_id"], name: "index_reviews_on_activity_id"
    t.index ["flat_id"], name: "index_reviews_on_flat_id"
    t.index ["trip_id"], name: "index_reviews_on_trip_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.boolean "ticket_used", default: false
    t.string "qr_code"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_tickets_on_order_id"
  end

  create_table "trip_photos", force: :cascade do |t|
    t.string "photo", default: "eu7793sw3rerfbltachi.jpg"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_trip_photos_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "destination"
    t.date "date_arriving"
    t.date "date_leaving"
    t.string "departing_from"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "funding_total_cents", default: 0, null: false
    t.integer "current_funding_amount_cents", default: 0, null: false
    t.string "ticket_name"
    t.text "ticket_description"
    t.integer "ticket_quantity"
    t.integer "ticket_price_cents", default: 0, null: false
    t.integer "available_tickets"
    t.float "longitude"
    t.float "latitude"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "profile_picture", default: "default-profile-pic-png-8.png"
    t.text "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "users"
  add_foreign_key "activity_photos", "activities"
  add_foreign_key "amenities", "flats"
  add_foreign_key "favourites", "activities"
  add_foreign_key "favourites", "flats"
  add_foreign_key "favourites", "trips"
  add_foreign_key "favourites", "users"
  add_foreign_key "flat_photos", "flats"
  add_foreign_key "flats", "users"
  add_foreign_key "friends", "users", column: "recipient_id"
  add_foreign_key "friends", "users", column: "sender_id"
  add_foreign_key "messages", "users", column: "recipient_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "orders", "activities"
  add_foreign_key "orders", "flats"
  add_foreign_key "orders", "trips"
  add_foreign_key "orders", "users"
  add_foreign_key "reviews", "activities"
  add_foreign_key "reviews", "flats"
  add_foreign_key "reviews", "trips"
  add_foreign_key "reviews", "users"
  add_foreign_key "tickets", "orders"
  add_foreign_key "trip_photos", "trips"
  add_foreign_key "trips", "users"
end
