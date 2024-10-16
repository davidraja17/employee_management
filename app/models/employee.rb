class Employee < ApplicationRecord
  validates :employee_id, presence: true, uniqueness: true
  validates :first_name, :last_name, :email, :date_of_joining, :monthly_salary, :phone_number, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :monthly_salary, numericality: { greater_than: 0 }

end
