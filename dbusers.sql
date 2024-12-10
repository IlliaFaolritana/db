use DBDataBase;

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employee';
CREATE USER 'accountant'@'localhost' IDENTIFIED BY 'accountant';

GRANT 'admin' TO 'admin'@'localhost';
GRANT 'employee' TO 'employee'@'localhost';
GRANT 'employee', 'accountant' TO 'accountant'@'localhost';
