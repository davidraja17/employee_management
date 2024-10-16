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

ActiveRecord::Schema.define(version: 2024_10_15_155649) do

  create_table "employees", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "employee_id", limit: 100, null: false
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "email", limit: 100, null: false
    t.string "phone_number", limit: 80, null: false
    t.date "date_of_joining", null: false
    t.decimal "monthly_salary", precision: 18, scale: 5, null: false
    t.string "status", default: "Active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_employees_on_employee_id"
    t.index ["monthly_salary"], name: "index_employees_on_monthly_salary"
  end

end
