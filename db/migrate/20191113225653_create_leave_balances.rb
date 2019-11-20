class CreateLeaveBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :leave_balances do |t|
      t.integer :balance
      t.references :leave, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
