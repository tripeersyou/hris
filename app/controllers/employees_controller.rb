class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :edit, :update, :destroy]

    def index
        @employees = Employee.where(is_terminated: false).eager_load(:employment_status)
    end
    def show
        if @employee.is_terminated
            redirect_to employees_path, alert: 'That employee is already terminated'
        end
    end
    def new
        @employee = Employee.new
    end
    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            redirect_to employees_path, notice: "Employee #{@employee} successfully created."
        else
            render :new, alert: "There seems to be a problem with your given information."
        end
    end
    def edit
    end
    def update
        if @employee.update(employee_params)
            redirect_to employees_path, notice: "Employee #{@employee} successfully updated"
        else
            render :edit, alert: "There seems to be a problem with your given information."
        end
    end
    def destroy
        @employee.terminate_employment
        redirect_to employees_path
    end
    private
        def employee_params
            params.require(:employee).permit!
        end
        def set_employee
            @employee = Employee.find(params[:id])
        end
end
