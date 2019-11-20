class Attendance < ApplicationRecord
  belongs_to :leave, optional: true
  belongs_to :employee
  belongs_to :holiday, optional: true
  validates :date, :is_present, :pay, presence: true
  validates :pay, numericality: {greater_than: 400}
end
