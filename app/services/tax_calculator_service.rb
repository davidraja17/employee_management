class TaxCalculatorService
  def initialize(salary, date_of_joining)
    @salary = salary
    @date_of_joining = date_of_joining
    @current_date = Date.today
  end

  # Calculate tax and return the necessary details
  def calculate_tax
    start_date, end_date = financial_year_dates(@current_date)
    working_days_in_financial_year = calculate_working_days(start_date, end_date)

    # Calculate the employee's actual worked days based on their date of joining
    actual_working_days = calculate_actual_working_days(start_date, end_date)

    # Calculate yearly salary based on days worked
    yearly_salary = (@salary / 30.0) * actual_working_days

    tax_amount = compute_tax(yearly_salary)
    cess_amount = compute_cess(yearly_salary)

    { yearly_salary: yearly_salary, tax_amount: tax_amount, cess_amount: cess_amount }
  end

  private

  # Calculate financial year start and end dates
  def financial_year_dates(current_date)
    year = current_date.year

    if current_date.month <= 3
      # Current date is before March 1
      start_date = Date.new(year - 1, 4, 1)  # April 1 of the previous year
      end_date = Date.new(year, 3, 31)       # March 31 of the current year
    else
      # Current date is April 1 or later
      start_date = Date.new(year, 4, 1)      # April 1 of the current year
      end_date = Date.new(year + 1, 3, 31)   # March 31 of the next year
    end

    [start_date, end_date]
  end

  # Calculate the total working days in the financial year
  def calculate_working_days(start_date, end_date)
    (end_date - start_date).to_i + 1  # Total days in the financial year
  end

  # Calculate the actual working days for the employee based on their date of joining
  def calculate_actual_working_days(start_date, end_date)
    # Ensure the employee's date of joining is within the financial year
    join_date = [@date_of_joining, start_date].max
    actual_days = (end_date - join_date).to_i + 1 # Calculate days worked

    actual_days > 0 ? actual_days : 0
  end

  # Compute the tax based on the yearly salary
  def compute_tax(yearly_salary)
    tax = 0

    if yearly_salary > 1_000_000
      tax += (yearly_salary - 1_000_000) * 0.20
      yearly_salary = 1_000_000
    end
    if yearly_salary > 500_000
      tax += (yearly_salary - 500_000) * 0.10
      yearly_salary = 500_000
    end
    if yearly_salary > 250_000
      tax += (yearly_salary - 250_000) * 0.05
    end

    tax.round(2)
  end

  # Compute the cess for salaries greater than 2.5 million
  def compute_cess(yearly_salary)
    cess = 0
    if yearly_salary > 2_500_000
      cess = (yearly_salary - 2_500_000) * 0.02
    end
    cess.round(2)
  end
end
