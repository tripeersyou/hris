class Leave < ApplicationRecord
    has_many :attendances
    has_many :leave_balances
    validates :type, :days, presence: true
    validates :days, numericality: {only_integer: true, greater_than: 0}
end
