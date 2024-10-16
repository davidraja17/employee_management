class EmployeeTaxSerializer < ActiveModel::Serializer
  attributes :employee_id, :first_name, :last_name, :yearly_salary, :tax_amount, :cess_amount

  # Custom attributes to include tax and salary details
  def yearly_salary
    instance_options[:yearly_salary]
  end

  def tax_amount
    instance_options[:tax_amount]
  end

  def cess_amount
    instance_options[:cess_amount]
  end
end

