class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :employee_id, limit: 100, null: false, unique: true
      t.string :first_name, limit: 100, null: false
      t.string :last_name, limit: 100, null: false
      t.string :email, limit: 100, null: false, unique: true
      t.string :phone_number, limit: 80, null: false
      t.date :date_of_joining, null: false
      t.decimal :monthly_salary, precision: 18, scale: 5, null: false
      t.string :status, default: "Active"

      t.timestamps
    end

    add_index :employees, :employee_id
    add_index :employees, :monthly_salary
  end
end
