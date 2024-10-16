module Api
  module V1
    class EmployeesController < ApplicationController
      before_action :set_employee, only: [:show, :update, :destroy, :tax_deduction]

      # GET api/v1/employees
      # Index action with Kaminari pagination
      def index
        # Paginate the employees, 100 records per page
        @employees = Employee.page(params[:page]).per(100)
        render json: {employees: @employees, meta: pagination_meta(@employees), status: :ok }
      end

      # GET api/v1employees/:id
      # Show action to fetch a single employee record by ID
      def show
        render json: @employee, status: :ok
      end

      # POST api/v1/employees/
      def create
        employee = Employee.new(employee_params)
        if employee.save
          render json: employee, serializer: EmployeeSerializer, status: :created
        else
          render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT api/v1/employees/:id
      # Update action to modify an employee's details
      def update
        if @employee.update(employee_params)
          render json: @employee, status: :ok
        else
          render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE api/v1/employees/:id
      # Delete action to make an employee status InActive
      # Making soft delete
      def destroy
        @employee.update_column(:status, "InActive")
        head :no_content  # 204 No Content response
      end

      def tax_deduction
        if @employee
          tax_service = TaxCalculatorService.new(@employee.monthly_salary, @employee.date_of_joining)
          tax_data = tax_service.calculate_tax

          # Use EmployeeTaxSerializer and pass custom options
          render json: @employee, serializer: EmployeeTaxSerializer, yearly_salary: tax_data[:yearly_salary], tax_amount: tax_data[:tax_amount], cess_amount: tax_data[:cess_amount], status: :ok
        else
          render json: { error: "Employee not found" }, status: :not_found
        end
      end

      private

      # Set employee for show, update, delete and tax_deduction actions
      def set_employee
        @employee = Employee.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Employee not found' }, status: :not_found
      end

      # Strong parameters for employee updates
      def employee_params
        params.require(:employee).permit(:first_name, :last_name, :email, :phone_number, :date_of_joining, :monthly_salary, :employee_id)
      end

      # Pagination metadata for Kaminari paginated response
      def pagination_meta(employees)
        {
          current_page: employees.current_page,
          next_page: employees.next_page,
          prev_page: employees.prev_page,
          total_pages: employees.total_pages,
          total_count: employees.total_count
        }
      end
    end
  end
end

