class CreateEmploymentStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :employment_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
