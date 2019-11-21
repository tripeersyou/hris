class CreateLeaves < ActiveRecord::Migration[6.0]
  def change
    create_table :leaves do |t|
      t.string :name
      t.integer :days

      t.timestamps
    end
  end
end
