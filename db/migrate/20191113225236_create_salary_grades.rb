class CreateSalaryGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :salary_grades do |t|
      t.string :grade
      t.decimal :daily_pay

      t.timestamps
    end
  end
end
