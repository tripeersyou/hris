class Employee < ApplicationRecord
  before_validation :set_age, :set_employment_status
  belongs_to :employment_status
  belongs_to :salary_grade
  has_many   :leave_balances
  has_many   :attendances
  validates :first_name, :last_name, :sex, :birthday, :age, :civil_status, :contact_number, :employment_date, :shift_start_time, :shift_end_time, :day_off, presence: true
  validates :sex, inclusion: {in: %w(Male Female)}
  validates :civil_status, inclusion: {in: ["Single", "Married", "Solo Parent"]}
  validates :day_off, inclusion: { in: %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)}
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 18}
  validates :contact_number,  length: {is: 11}, numericality: true
  validates :pagibig_number, :philhealth_number, length: {is: 12}, numericality: true, allow_blank: true
  validates :sss_number, length: {is: 10}, numericality: true, allow_blank: true
  validates :tin_number, length: {is: 9}, numericality:  true, allow_blank: true

  def set_employment_status
    if  Date.today.month - employment_date.month < 6 and is_terminated == false
        self.employment_status = EmploymentStatus.find_by(status: "Probation")
    elsif   Date.today.month - employment_date.month >= 6 and is_terminated == false
        self.employment_status = EmploymentStatus.find_by(status: "Regular")
    end
  end

  def years_employed
    Date.today.year - self.employment_date.year
  end

  def set_age
    self.age = Date.today.year - self.birthday.year
  end

  def shift 
    "#{shift_start_time.strftime("%r")} - #{shift_end_time.strftime("%r")}"
  end

  def to_s
    "#{first_name} #{last_name}"
  end
  def generate_leave_balances
    Leave.all.each do |leave|
        if leave.name == "Service Incentive Leave"
            if years_employed >= 1
                LeaveBalance.create({employee_id: self.id, leave_id: leave.id, balance: leave.days})
            end
        elsif leave.name == "Maternity Leave"
            if sex == "Female" and civil_status == "Married"
                LeaveBalance.create({employee_id: self.id, leave_id: leave.id, balance: leave.days})
            end
        elsif leave.name == "Paternity Leave"
            if sex == "Male" and civil_status == "Married"
                LeaveBalance.create({employee_id: self.id, leave_id: leave.id, balance: leave.days})
            end
        elsif leave.name == "Solo Parent Leave"
            if civil_status == "Solo Parent"
                LeaveBalance.create({employee_id: self.id, leave_id: leave.id, balance: leave.days})
            end
        elsif leave.name == "VAWC Leave"
            if sex == "Female"
                LeaveBalance.create({employee_id: self.id, leave_id: leave.id, balance: leave.days})
            end
        end
    end
  end

end