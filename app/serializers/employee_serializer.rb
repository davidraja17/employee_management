class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :employee_id, :first_name, :last_name, :email, :phone_number, :date_of_joining, :monthly_salary, :status
end
