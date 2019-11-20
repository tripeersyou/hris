class LeaveBalance < ApplicationRecord
  belongs_to :leave
  belongs_to :employee
  validates :balance, numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
