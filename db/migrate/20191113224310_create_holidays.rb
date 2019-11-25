class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|
      t.string :name
      t.text :description
      t.date :date
      t.string :kind
      t.string :weekday

      t.timestamps
    end
  end
end
