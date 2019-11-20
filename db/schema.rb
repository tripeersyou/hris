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

ActiveRecord::Schema.define(version: 2019_11_20_061310) do

  create_table "attendances", force: :cascade do |t|
    t.date "date"
    t.boolean "is_present"
    t.decimal "pay"
    t.boolean "on_leave"
    t.integer "leave_id", null: false
    t.integer "employee_id", null: false
    t.integer "holiday_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
    t.index ["holiday_id"], name: "index_attendances_on_holiday_id"
    t.index ["leave_id"], name: "index_attendances_on_leave_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "sex"
    t.date "birthday"
    t.integer "age"
    t.string "contact_number"
    t.string "pagibig_number"
    t.string "sss_number"
    t.string "philhealth_number"
    t.string "tin_number"
    t.date "employment_date"
    t.date "termination_date"
    t.boolean "is_terminated"
    t.time "shift_start_time"
    t.time "shift_end_time"
    t.string "day_off"
    t.integer "employment_status_id", null: false
    t.integer "salary_grade_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employment_status_id"], name: "index_employees_on_employment_status_id"
    t.index ["salary_grade_id"], name: "index_employees_on_salary_grade_id"
  end

  create_table "employment_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "date"
    t.string "type"
    t.string "weekday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "leave_balances", force: :cascade do |t|
    t.integer "balance"
    t.integer "leave_id", null: false
    t.integer "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_leave_balances_on_employee_id"
    t.index ["leave_id"], name: "index_leave_balances_on_leave_id"
  end

  create_table "leaves", force: :cascade do |t|
    t.string "type"
    t.integer "days"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "salary_grades", force: :cascade do |t|
    t.string "grade"
    t.decimal "daily_pay"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "attendances", "employees"
  add_foreign_key "attendances", "holidays"
  add_foreign_key "attendances", "leaves"
  add_foreign_key "employees", "employment_statuses"
  add_foreign_key "employees", "salary_grades"
  add_foreign_key "leave_balances", "employees"
  add_foreign_key "leave_balances", "leaves"
end
