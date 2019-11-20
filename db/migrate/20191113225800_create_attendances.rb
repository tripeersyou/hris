class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.date :date
      t.boolean :is_present
      t.decimal :pay
      t.boolean :on_leave
      t.references :leave, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.references :holiday, null: false, foreign_key: true

      t.timestamps
    end
  end
end
