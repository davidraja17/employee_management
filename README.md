# README

This README would normally document whatever steps are necessary to get the
application up and running.

# Ruby version & Rails Version
  - Ruby version: 3.0.4
  - Rails version: 6.1.7

# System dependencies
  - MySql

# Database creation
 - rails db:create
 - rails db:migrate

# How to run the test suite
 - bundle exec rspec
   
 - covered all the Rspec coverage

---

# Employees API Documentation

## Base URL
```
/api/v1/employees
```

---

### 1. Get All Employees (with Pagination)

**Endpoint:**  
`GET /api/v1/employees`

**Description:**  
Fetch a paginated list of all employees, 100 records per page.

**Request Parameters:**

| Parameter | Type   | Description                             |
|-----------|--------|-----------------------------------------|
| `page`    | `int`  | (Optional) Page number for pagination.   |

**Response:**

- **200 OK**: Returns a paginated list of employees.
- **Meta Information**: Contains pagination details (`current_page`, `next_page`, etc.).

**Sample Request:**
```bash
GET /api/v1/employees?page=1
```

**Sample Response:**
```json
{
  "employees": [
    {
      "id": 1,
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.doe@example.com",
      "phone_number": "1234567890",
      "date_of_joining": "2020-05-01",
      "monthly_salary": 60000,
      "employee_id": "EMP001"
    }
  ],
  "meta": {
    "current_page": 1,
    "next_page": null,
    "prev_page": null,
    "total_pages": 1,
    "total_count": 1
  },
  "status": "ok"
}
```

---

### 2. Get Single Employee

**Endpoint:**  
`GET /api/v1/employees/:id`

**Description:**  
Fetch a single employee by employee primary key id.

**Request Parameters:**

| Parameter | Type   | Description           |
|-----------|--------|-----------------------|
| `id`      | `int`  | employee primary key id. |

**Response:**

- **200 OK**: Returns the employee record.
- **404 Not Found**: If the employee is not found.

**Sample Request:**
```bash
GET /api/v1/employees/1
```

**Sample Response:**
```json
{
  "id": 1,
  "first_name": "John",
  "last_name": "Doe",
  "email": "john.doe@example.com",
  "phone_number": "1234567890",
  "date_of_joining": "2020-05-01",
  "monthly_salary": 60000,
  "employee_id": "EMP001",
  "status": "ok"
}
```

---

### 3. Create Employee

**Endpoint:**  
`POST /api/v1/employees`

**Description:**  
Create a new employee.

**Request Body:**

| Parameter         | Type      | Description                                      |
|-------------------|-----------|--------------------------------------------------|
| `first_name`       | `string`  | First name of the employee.                      |
| `last_name`        | `string`  | Last name of the employee.                       |
| `email`            | `string`  | Employee's email address.                        |
| `phone_number`     | `string`  | Employee's phone number.                         |
| `date_of_joining`  | `date`    | Date of joining the organization.                |
| `monthly_salary`   | `decimal` | Monthly salary of the employee.                  |
| `employee_id`      | `string`  | Unique employee ID.                              |

**Response:**

- **201 Created**: Returns the created employee record.
- **422 Unprocessable Entity**: If validation errors occur.

**Sample Request:**
```json
{
  "first_name": "Jane",
  "last_name": "Doe",
  "email": "jane.doe@example.com",
  "phone_number": "9876543210",
  "date_of_joining": "2021-01-15",
  "monthly_salary": 65000,
  "employee_id": "EMP002"
}
```

**Sample Response:**
```json
{
  "id": 2,
  "first_name": "Jane",
  "last_name": "Doe",
  "email": "jane.doe@example.com",
  "phone_number": "9876543210",
  "date_of_joining": "2021-01-15",
  "monthly_salary": 65000,
  "employee_id": "EMP002",
  "status": "created"
}
```

---

### 4. Update Employee

**Endpoint:**  
`PUT /api/v1/employees/:id`

**Description:**  
Update details of an existing employee.

**Request Parameters:**

| Parameter | Type   | Description              |
|-----------|--------|--------------------------|
| `id`      | `int`  | employee primary key id to update.    |

**Request Body:**

| Parameter         | Type      | Description                                      |
|-------------------|-----------|--------------------------------------------------|
| `first_name`       | `string`  | (Optional) First name of the employee.           |
| `last_name`        | `string`  | (Optional) Last name of the employee.            |
| `email`            | `string`  | (Optional) Employee's email address.             |
| `phone_number`     | `string`  | (Optional) Employee's phone number.              |
| `date_of_joining`  | `date`    | (Optional) Date of joining the organization.     |
| `monthly_salary`   | `decimal` | (Optional) Monthly salary of the employee.       |

**Response:**

- **200 OK**: Returns the updated employee record.
- **422 Unprocessable Entity**: If validation errors occur.
- **404 Not Found**: If the employee is not found.

**Sample Request:**
```json
{
  "first_name": "Jane Updated",
  "monthly_salary": 70000
}
```

**Sample Response:**
```json
{
  "id": 2,
  "first_name": "Jane Updated",
  "last_name": "Doe",
  "email": "jane.doe@example.com",
  "phone_number": "9876543210",
  "date_of_joining": "2021-01-15",
  "monthly_salary": 70000,
  "employee_id": "EMP002",
  "status": "ok"
}
```

---

### 5. Delete (Soft Delete) Employee

**Endpoint:**  
`DELETE /api/v1/employees/:id`

**Description:**  
Soft delete an employee by marking their status as `InActive`.

**Request Parameters:**

| Parameter | Type   | Description              |
|-----------|--------|--------------------------|
| `id`      | `int`  | employee primary key id to make status InActive.    |

**Response:**

- **204 No Content**: When the employee is successfully soft deleted.
- **404 Not Found**: If the employee is not found.

**Sample Request:**
```bash
DELETE /api/v1/employees/2
```

**Sample Response:**
```
204 No Content
```

---

### 6. Get Employee Tax Deduction

**Endpoint:**  
`GET /api/v1/employees/:id/tax_deduction`

**Description:**  
Calculate tax deduction for an employee for the current financial year.

**Request Parameters:**

| Parameter | Type   | Description           |
|-----------|--------|-----------------------|
| `id`      | `int`  | employee primary key id to fetch. |

**Response:**

- **200 OK**: Returns the employee’s tax deduction details.
- **404 Not Found**: If the employee is not found.

**Sample Request:**
```bash
GET /api/v1/employees/2/tax_deduction
```

**Sample Response:**
```json
{
  "employee_id": "EMP002",
  "first_name": "Jane",
  "last_name": "Doe",
  "yearly_salary": 780000,
  "tax_amount": 60000,
  "cess_amount": 0,
  "status": "ok"
}
```

---

### Error Responses

All endpoints may return the following error responses where applicable:

| Status Code | Description                  |
|-------------|------------------------------|
| 404         | Resource not found.           |
| 422         | Unprocessable entity (validation error). |

---

### Pagination

For paginated responses (e.g., the `index` endpoint), the following metadata will be returned:

```json
{
  "meta": {
    "current_page": 1,
    "next_page": 2,
    "prev_page": null,
    "total_pages": 10,
    "total_count": 100
  }
}
```

---
