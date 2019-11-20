class Holiday < ApplicationRecord
    has_many :attendances
    validates :name, :date, :type, :weekday, presence: true
    validates :date, uniqueness: true
end
