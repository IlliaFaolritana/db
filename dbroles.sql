use DBDataBase;

CREATE ROLE 'admin', 'employee', 'accountant';

GRANT ALL ON DBDataBase.* TO 'admin';

GRANT SELECT ON DBDataBase.* TO 'employee';
GRANT INSERT ON DBDataBase.expense_reports TO 'employee';

GRANT SELECT ON DBDataBase.* TO 'accountant';
GRANT UPDATE, DELETE ON DBDataBase.expense_reports TO 'accountant';