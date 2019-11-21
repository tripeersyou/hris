class SalaryGrade < ApplicationRecord
    has_many :employees
    validates :grade, :daily_pay, presence: true
    validates :daily_pay, numericality: {greater_than_or_equal_to: 400}

    def to_s
        "Grade #{grade} - Php #{daily_pay} Daily Pay"
    end
end
