class PagesController < ApplicationController
  protect_from_forgery except: :service_worker
  def dashboard
    @employees_today = Employee.expected_today
    @holidays = Holiday.next_five
  end

  # For PWA
  def service_worker

  end
  def manifest

  end
end
