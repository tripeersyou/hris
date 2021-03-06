class EmploymentStatus < ApplicationRecord
    has_many :employees
    validates :status, presence: true
    validates :status, inclusion: { in: %w(Probation Regular Terminated)}

    def to_s
        status
    end
end
