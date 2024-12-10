ALTER TABLE employees
DROP CONSTRAINT CHK_employee_name;

ALTER TABLE departments
DROP INDEX department_creation_date;

ALTER TABLE departments
DROP COLUMN department_creation_date;

DROP TABLE expense_reports;