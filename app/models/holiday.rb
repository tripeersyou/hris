class Holiday < ApplicationRecord
    has_many :attendances
    validates :name, :date, :kind, :weekday, presence: true
    validate :name_and_date_unique

    # Custom validation method
    def name_and_date_unique
        holidays = Holiday.where(date: self.date)
        if !holidays.empty?
            holidays.each do |h|
                if h.name == self.name
                    errors.add(:name, "is already recorded")
                end
            end
        end
    end
    # View methods
    def to_s
        name
    end
    # Instance methods
    def self.next_five
        Holiday.where(date: Date.today + 1...1.year.from_now).order(date: :asc).limit(5)
    end

    def self.future_holidays
        Holiday.where(date: Date.today + 1...1.year.from_now).order(date: :asc)
    end
end
