class Employee < ApplicationRecord
  before_validation :set_age, :set_employment_status, :titleize_name
  after_create :generate_leave_balances
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


  # Model change methods
  def months_served
    (Date.today.year * 12 + Date.today.month) - (employment_date.year * 12 + employment_date.month)
  end

  def set_employment_status
    if months_served < 6
        self.employment_status = EmploymentStatus.find_by(status: "Probation")
    else
        self.employment_status = EmploymentStatus.find_by(status: "Regular")
    end
  end

  def terminate_employment
    self.is_terminated = true
    self.employment_status = EmploymentStatus.find_by(status: "Terminated")
    self.termination_date = Date.today
    save
  end

  def years_employed
    Date.today.year - self.employment_date.year
  end

  def set_age
    self.age = ((Time.now - self.birthday.to_time) / 1.year.seconds).floor
  end

  # View Methods
  def attendance_today
    self.attendances.where(date: Date.today)
  end
  def shift 
    "#{shift_start_time.strftime("%r")} - #{shift_end_time.strftime("%r")}"
  end

  def daily_pay
    self.salary_grade.daily_pay
  end

  def estimated_weekly_pay
    daily_pay * 6
  end

  def estimated_monthly_pay
    estimated_weekly_pay * 4
  end

  def estimated_thirteenth_month_pay
    if (Date.new(Date.today.year, 12, 24).year * 12 + Date.new(Date.today.year, 12, 24).month) - (employment_date.year * 12 + employment_date.month) < 12
      prorated_months = (Date.new(Date.today.year, 12, 24).year * 12 + Date.new(Date.today.year, 12, 24).month) - (employment_date.year * 12 + employment_date.month) + 1
      proration = prorated_months / 12.0
      (proration * estimated_monthly_pay).round(2)
    else 
      estimated_monthly_pay
    end 
  end

  def titleize_name
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end

  def weekly_attendance
    weekly_attendance = self.attendances.where(is_present: true, date: Date.today.at_beginning_of_week..Date.today)
  end
  
  def monthly_attendance
    monthly_attendance = self.attendances.where(is_present: true, date: Date.today.at_beginning_of_month..Date.today)
  end

  def week_to_date_pay
    if weekly_attendance.empty?
      "No attendance yet for this week."
    else
      weekly_attendance.each do |attendance|
        pay = attendance.daily_pay
      end
      "Php #{pay}"
    end
  end

  def month_to_date_pay
    if monthly_attendance.empty?
      "No attendance yet for this month."
    else
      monthly_attendance.each do |attendance|
        pay = attendance.daily_pay
      end
      "Php #{pay}"
    end
  end

  def pay_today
    attendance_today = self.attendances.where(date: Date.today)
    if !attendance_today.empty?
      attendance_today = attendance_today.first
      if attendance_today.date.strftime("%A") == self.day_off && attendance_today.is_present == false
        "Day off, no pay"
      elsif attendance_today.date.strftime("%A") != self.day_off && attendoance_today.is_present == false
        "Absent, no pay"
      elsif attendance_today.date.strftime("%A") != self.day_off && attendance_today.is_present == true
        "Php #{attendance_today.pay}"
      end
    else 
      "No attendance recorded yet today"
    end
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  # Async Functions
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
  handle_asynchronously :generate_leave_balances

  # Instance methods
  def self.expected_today
    Employee.where.not(day_off: Date.today.strftime("%A")).where('employment_date <= ?', Date.today).where(is_terminated: false).order(shift_start_time: :asc)
  end

  def self.day_off_today
    Employee.where(day_off: Date.today.strftime("%A")).where('employment_date <= ?', Date.today).where(is_terminated: false).order(shift_start_time: :asc)
  end

end