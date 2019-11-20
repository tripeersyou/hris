class SalaryGrade < ApplicationRecord
    has_many :employees
    validates :grade, :daily_pay, presence: true
    validates :daily_pay, numericality: {greater_than: 400}
end
