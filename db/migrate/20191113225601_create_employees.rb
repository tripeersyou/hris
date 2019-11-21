class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :civil_status
      t.string :sex
      t.date :birthday
      t.integer :age
      t.string :contact_number
      t.string :pagibig_number
      t.string :sss_number
      t.string :philhealth_number
      t.string :tin_number
      t.date :employment_date
      t.date :termination_date
      t.boolean :is_terminated, default: false
      t.time :shift_start_time
      t.time :shift_end_time
      t.string :day_off
      t.references :employment_status, null: false, foreign_key: true
      t.references :salary_grade, null: false, foreign_key: true

      t.timestamps
    end
  end
end
