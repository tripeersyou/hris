class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :edit, :update]

    def index
        @employees = Employee.all
    end
    def show
    end
    def new
        @employee = Employee.new
    end
    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            @employee.delay.generate_leave_balances
            redirect_to '/employees'
        else
            render :new
        end
    end
    def edit
    end
    def update
    end
    def destroy
    end
    private
        def employee_params
            params.require(:employee).permit!
        end
        def set_employee
            @employee = Employee.find(params[:id])
        end
end
