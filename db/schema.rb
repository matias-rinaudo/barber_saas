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

ActiveRecord::Schema[7.2].define(version: 2025_09_01_215807) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "barbershop_id", null: false
    t.bigint "barber_id", null: false
    t.bigint "customer_id", null: false
    t.bigint "treatment_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "appointment_date", null: false
    t.bigint "branch_id"
    t.index ["barber_id", "start_time"], name: "index_appointments_on_barber_id_and_start_time"
    t.index ["barber_id"], name: "index_appointments_on_barber_id"
    t.index ["barbershop_id", "status"], name: "index_appointments_on_barbershop_id_and_status"
    t.index ["barbershop_id"], name: "index_appointments_on_barbershop_id"
    t.index ["branch_id", "appointment_date"], name: "index_appointments_on_branch_id_and_appointment_date"
    t.index ["branch_id", "barber_id"], name: "index_appointments_on_branch_id_and_barber_id"
    t.index ["branch_id", "start_time"], name: "index_appointments_on_branch_id_and_start_time"
    t.index ["branch_id", "status"], name: "index_appointments_on_branch_id_and_status"
    t.index ["branch_id"], name: "index_appointments_on_branch_id"
    t.index ["customer_id", "start_time"], name: "index_appointments_on_customer_id_and_start_time"
    t.index ["customer_id"], name: "index_appointments_on_customer_id"
    t.index ["treatment_id"], name: "index_appointments_on_treatment_id"
  end

  create_table "barber_branches", force: :cascade do |t|
    t.bigint "barber_id", null: false
    t.bigint "branch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barber_id", "branch_id"], name: "index_barber_branches_on_barber_id_and_branch_id", unique: true
    t.index ["barber_id"], name: "index_barber_branches_on_barber_id"
    t.index ["branch_id", "barber_id"], name: "index_barber_branches_on_branch_id_and_barber_id"
    t.index ["branch_id"], name: "index_barber_branches_on_branch_id"
    t.index ["created_at"], name: "index_barber_branches_on_created_at"
  end

  create_table "barbers", force: :cascade do |t|
    t.bigint "barbershop_id", null: false
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.boolean "active", default: true
    t.index ["barbershop_id", "active"], name: "index_barbers_on_barbershop_id_and_active"
    t.index ["barbershop_id"], name: "index_barbers_on_barbershop_id"
    t.index ["user_id"], name: "index_barbers_on_user_id"
  end

  create_table "barbershops", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "branches", force: :cascade do |t|
    t.bigint "barbershop_id", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone", null: false
    t.string "email"
    t.text "description"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.json "working_hours"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barbershop_id", "active"], name: "index_branches_on_barbershop_id_and_active"
    t.index ["barbershop_id", "name"], name: "index_branches_on_barbershop_id_and_name"
    t.index ["barbershop_id"], name: "index_branches_on_barbershop_id"
    t.index ["name"], name: "index_branches_on_name"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "barbershop_id", null: false
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["barbershop_id"], name: "index_customers_on_barbershop_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "barbershop_id", null: false
    t.string "status", default: "active"
    t.string "mercado_pago_subscription_id"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barbershop_id"], name: "index_subscriptions_on_barbershop_id"
  end

  create_table "treatments", force: :cascade do |t|
    t.bigint "barbershop_id", null: false
    t.string "name", null: false
    t.text "description"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "duration_minutes", default: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration", null: false, comment: "Duración en minutos"
    t.boolean "active", default: true
    t.bigint "branch_id"
    t.index ["barbershop_id", "active"], name: "index_treatments_on_barbershop_id_and_active"
    t.index ["barbershop_id"], name: "index_treatments_on_barbershop_id"
    t.index ["branch_id", "active"], name: "index_treatments_on_branch_id_and_active"
    t.index ["branch_id"], name: "index_treatments_on_branch_id"
    t.index ["name"], name: "index_treatments_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "barbershop_id"
    t.index ["barbershop_id"], name: "index_users_on_barbershop_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "barbers"
  add_foreign_key "appointments", "barbershops"
  add_foreign_key "appointments", "branches"
  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "treatments"
  add_foreign_key "barber_branches", "barbers"
  add_foreign_key "barber_branches", "branches"
  add_foreign_key "barbers", "barbershops"
  add_foreign_key "barbers", "users"
  add_foreign_key "branches", "barbershops"
  add_foreign_key "customers", "barbershops"
  add_foreign_key "customers", "users"
  add_foreign_key "subscriptions", "barbershops"
  add_foreign_key "treatments", "barbershops"
  add_foreign_key "treatments", "branches"
  add_foreign_key "users", "barbershops"
end
