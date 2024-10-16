FactoryBot.define do
  factory :employee do
    employee_id { Faker::Alphanumeric.alphanumeric(number: 5).upcase }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    date_of_joining { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    monthly_salary { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
    status { "Active" }
  end
end

