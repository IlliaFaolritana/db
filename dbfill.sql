use DBDataBase;

INSERT INTO department_limits (DL_amount, DL_end_date) VALUES 
(10000.00, '2024-12-31'),
(20000.00, '2024-12-31'),
(15000.00, '2024-12-31'),
(30000.00, '2024-12-31'),
(5000.00, '2024-12-31'),
(25000.00, '2024-12-31'),
(1000.00, '2024-12-31'),
(12000.00, '2024-12-31'),
(18000.00, '2024-12-31'),
(22000.00, '2024-12-31');

INSERT INTO departments (department_name, department_limit_id) VALUES
('HR', 1),
('IT', 2),
('Finance', 3),
('Marketing', 4),
('Operations', 5),
('Legal', 6),
('Procurement', 7),
('Logistics', 8),
('R&D', 9),
('Sales', 10);

INSERT INTO expense_type_limits (ETL_amount, ETL_end_date) VALUES 
(500.00, '2024-12-31'),
(1000.00, '2024-12-31'),
(2000.00, '2024-12-31'),
(1500.00, '2024-12-31'),
(700.00, '2024-12-31'),
(1200.00, '2024-12-31'),
(250.00, '2024-12-31'),
(3000.00, '2024-12-31'),
(800.00, '2024-12-31'),
(4000.00, '2024-12-31');

INSERT INTO expense_types (ET_name, ET_description, expense_type_limit_id, departmenet_id) VALUES
('Travel', 'Expenses related to business travel', 1, 1),
('Office Supplies', 'Expenses for office items', 2, 2),
('Utilities', 'Electricity and water bills', 3, 3),
('Entertainment', 'Client dinners or events', 4, 4),
('Training', 'Employee training programs', 5, 5),
('Legal Fees', 'Costs related to legal matters', 6, 6),
('Advertising', 'Expenses for advertising', 7, 7),
('Consulting', 'Payments to consultants', 8, 8),
('Maintenance', 'Repair and maintenance costs', 9, 9),
('Recruitment', 'Costs related to hiring', 10, 10);

INSERT INTO employees (employee_name, employee_surname, department_id, employee_position, employee_phone_number, employee_email, employee_birth_date, employee_salary) VALUES
('John', 'Doe', 1, 'Manager', '1234567890', 'john.doe@example.com', '1985-06-15', 5000.00),
('Jane', 'Smith', 2, 'Lead Developer', '1234567891', 'jane.smith@example.com', '1990-07-20', 6000.00),
('Robert', 'Brown', 3, 'Accountant', '1234567892', 'robert.brown@example.com', '1982-09-25', 4000.00),
('Emily', 'White', 4, 'Marketing Manager', '1234567893', 'emily.white@example.com', '1987-11-10', 5500.00),
('Michael', 'Davis', 5, 'Operations Head', '1234567894', 'michael.davis@example.com', '1983-03-12', 5300.00),
('Sarah', 'Taylor', 6, 'Legal Advisor', '1234567895', 'sarah.taylor@example.com', '1988-08-05', 4500.00),
('David', 'Wilson', 7, 'Procurement Lead', '1234567896', 'david.wilson@example.com', '1979-12-17', 4800.00),
('Sophia', 'Moore', 8, 'Logistics Manager', '1234567897', 'sophia.moore@example.com', '1984-02-27', 5200.00),
('James', 'Anderson', 9, 'R&D Specialist', '1234567898', 'james.anderson@example.com', '1991-05-23', 6100.00),
('Linda', 'Clark', 10, 'Sales Executive', '1234567899', 'linda.clark@example.com', '1993-04-18', 4700.00);

INSERT INTO expense_reports (departmenet_id, employee_id, expense_type_id, ER_date, ER_total, ER_accountant_approval) VALUES
(1, 1, 1, '2024-01-15', 200.00, 1),
(2, 2, 2, '2024-02-10', 300.00, 1),
(3, 3, 3, '2024-03-05', 400.00, 0),
(4, 4, 4, '2024-04-20', 150.00, 1),
(5, 5, 5, '2024-05-25', 250.00, 0),
(6, 6, 6, '2024-06-15', 500.00, 1),
(7, 7, 7, '2024-07-10', 350.00, 1),
(8, 8, 8, '2024-08-05', 450.00, 0),
(9, 9, 9, '2024-09-20', 600.00, 1),
(10, 10, 10, '2024-10-25', 700.00, 1);

UPDATE departments SET department_manager_id = 1 WHERE department_id = 1;
UPDATE departments SET department_manager_id = 2 WHERE department_id = 2;
UPDATE departments SET department_manager_id = 3 WHERE department_id = 3;
UPDATE departments SET department_manager_id = 4 WHERE department_id = 4;
UPDATE departments SET department_manager_id = 5 WHERE department_id = 5;
UPDATE departments SET department_manager_id = 6 WHERE department_id = 6;
UPDATE departments SET department_manager_id = 7 WHERE department_id = 7;
UPDATE departments SET department_manager_id = 8 WHERE department_id = 8;
UPDATE departments SET department_manager_id = 9 WHERE department_id = 9;
UPDATE departments SET department_manager_id = 10 WHERE department_id = 10;


UPDATE departments SET department_head_id = 1 WHERE department_id = 1;
UPDATE departments SET department_head_id = 5 WHERE department_id = 2;
UPDATE departments SET department_head_id = 9 WHERE department_id = 3;
UPDATE departments SET department_head_id = 13 WHERE department_id = 4;
UPDATE departments SET department_head_id = 17 WHERE department_id = 5;
UPDATE departments SET department_head_id = 21 WHERE department_id = 6;
UPDATE departments SET department_head_id = 25 WHERE department_id = 7;
UPDATE departments SET department_head_id = 29 WHERE department_id = 8;
UPDATE departments SET department_head_id = 33 WHERE department_id = 9;
UPDATE departments SET department_head_id = 37 WHERE department_id = 10;
UPDATE departments SET department_head_id = 41 WHERE department_id = 11;
UPDATE departments SET department_head_id = 45 WHERE department_id = 12;
UPDATE departments SET department_head_id = 49 WHERE department_id = 13;
UPDATE departments SET department_head_id = 53 WHERE department_id = 14;
UPDATE departments SET department_head_id = 57 WHERE department_id = 15;
UPDATE departments SET department_head_id = 61 WHERE department_id = 16;
UPDATE departments SET department_head_id = 65 WHERE department_id = 17;
UPDATE departments SET department_head_id = 69 WHERE department_id = 18;
UPDATE departments SET department_head_id = 73 WHERE department_id = 19;
UPDATE departments SET department_head_id = 77 WHERE department_id = 20;