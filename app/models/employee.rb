class Employee < ApplicationRecord
  belongs_to :employment_status
  belongs_to :salary_grade
  has_many   :leave_balances
  has_many   :attendances
  validates :first_name, :last_name, :sex, :birthday, :age, :contact_number, :employment_date, :shift_start_time, :shift_end_time, :day_off, presence: true
  validates :sex, inclusion: {in: %w(Male Female)}
  validates :day_off, inclusion: { in: %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)}
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 18}
  validates :contact_number,  length: {is: 11}, numericality: true
  validates :pagibig_number, :philhealth_number, length: {is: 12}, numericality: true, allow_blank: true
  validates :sss_number, length: {is: 10}, numericality: true, allow_blank: true
  validates :tin_number, length: {is: 9}, numericality:  true, allow_blank: true
end