CREATE DATABASE DBDataBase;

USE DBDataBase;

CREATE TABLE department_limits(
	DL_id INT AUTO_INCREMENT,
    DL_amount DECIMAL(8, 2) NOT NULL,
    DL_end_date DATE NOT NULL,
    
    PRIMARY KEY (DL_id)
);

CREATE TABLE departments(
	department_id INT AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    department_limit_id INT DEFAULT NULL,
    department_head_id INT DEFAULT NULL,
    
    PRIMARY KEY (department_id),
    CONSTRAINT FK_department_to_department_limit FOREIGN KEY (department_limit_id)
    REFERENCES department_limits(DL_id) ON DELETE SET NULL ON UPDATE cascade
);

CREATE TABLE expense_type_limits(
	ETL_id INT AUTO_INCREMENT,
    ETL_amount DECIMAL(8, 2) NOT NULL,
    ETL_end_date DATE NOT NULL,
    
    PRIMARY KEY (ETL_id)
);

CREATE TABLE expense_types(
	ET_id INT AUTO_INCREMENT,
    ET_name VARCHAR(50) NOT NULL,
    ET_description VARCHAR(255) NOT NULL,
    expense_type_limit_id INT DEFAULT NULL,
    departmenet_id INT DEFAULT NULL,
    
    PRIMARY KEY (ET_id),
    CONSTRAINT FK_expense_type_to_expense_type_limit FOREIGN KEY (expense_type_limit_id)
    REFERENCES expense_type_limits(ETL_id) ON DELETE SET NULL ON UPDATE cascade,
    CONSTRAINT FK_expense_type_to_department FOREIGN KEY (departmenet_id)
    REFERENCES departments(department_id) ON DELETE SET NULL ON UPDATE cascade
);

CREATE TABLE employees(
	employee_id INT AUTO_INCREMENT,
    employee_name VARCHAR(50) NOT NULL,
    employee_surname VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    employee_position VARCHAR(50) NOT NULL,
    employee_phone_number VARCHAR(15),
    employee_email VARCHAR(320),
    employee_birth_date DATE,
    employee_salary DECIMAL(8, 2) NOT NULL,
    employee_employed_status BOOL DEFAULT 1,
    
    PRIMARY KEY (employee_id),
    CONSTRAINT FK_employee_to_department FOREIGN KEY (department_id)
    REFERENCES departments(department_id) ON DELETE cascade ON UPDATE cascade
);

CREATE TABLE expense_reports(
	ER_id INT AUTO_INCREMENT,
    departmenet_id INT NOT NULL,
    employee_id INT NOT NULL,
    expense_type_id INT NOT NULL,
    ER_date DATE NOT NULL,
    ER_total DECIMAL(8, 2) NOT NULL,
    ER_accountant_approval BOOL DEFAULT 0,
    
    PRIMARY KEY (ER_id),
    CONSTRAINT FK_expense_report_to_department FOREIGN KEY (departmenet_id)
    REFERENCES departments(department_id) ON DELETE cascade ON UPDATE cascade,
    CONSTRAINT FK_expense_report_to_employee FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id) ON DELETE cascade ON UPDATE cascade,
    CONSTRAINT FK__expense_report_to_expense_type FOREIGN KEY (expense_type_id)
    REFERENCES expense_types(ET_id) ON DELETE cascade ON UPDATE cascade
);

ALTER TABLE departments
ADD CONSTRAINT FK_department_to_department_head FOREIGN KEY (department_head_id)
REFERENCES employees(employee_id) ON DELETE SET NULL ON UPDATE cascade;