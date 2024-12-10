use DBDataBase;

SELECT * FROM employees WHERE employee_salary > 5700;
-- Вибрати працівників з зарплатнею більшою за 5700

SELECT * FROM expense_reports WHERE ER_total < 13 AND NOT ER_accountant_approval;
-- Вибрати звіти з сумою менше 13 і не підтверджені бухгалтером

SELECT * FROM department_limits WHERE DL_amount * 0.66 <= 1000;
-- Вибрати ліміти департаментів де сума буде меншою за 1000 при урізці на третину
SELECT employee_id, employee_name, employee_surname, employee_salary * 12 AS annual_salary FROM employees;
-- Показати річні зарплатні працівників

SELECT * FROM departments WHERE department_name IN ("HR", "Finance", "IT");
-- Вибрати департаменти HR Finance та IT

SELECT * FROM expense_type_limits WHERE ETL_amount BETWEEN 1000 AND 1050;
-- Вибрати ліміти по видам витрати що 1000 < сума < 1050 

SELECT * FROM employees WHERE employee_birth_date LIKE "1989%";
-- Вибрати працівників 1989 року народження
SELECT * FROM employees WHERE employee_phone_number LIKE "+38050______1";
-- Вибрати працівників з номером телефону, що має оператора 050 і закінчується одиницею

-- 2)-------------------------------------------------------------------------------------------------------

SELECT d.department_name,
    (SELECT SUM(e.employee_salary) 
     FROM employees e 
     WHERE e.department_id = d.department_id) AS total_salary
FROM departments d;
-- Знайти суми, що витрачаються на зарплатні в кожному відділі
SELECT MAX(employee_total)
FROM
	(SELECT SUM(ER_total) AS employee_total 
	FROM expense_reports
    GROUP BY employee_id) AS MAX_EMPLOYEE_TOTAL;
-- Знайти працівника з найбільшою сумою всіх витрат

SELECT department_id, department_name
FROM departments d
WHERE EXISTS
	(SELECT 1 
    FROM employees e 
    WHERE e.department_id = d.department_id AND e.employee_salary >= 6000);
-- Знайти відділи, де хоча б один співробітник має зарплатню >= 6000
SELECT department_id, department_name 
FROM departments d
WHERE department_head_id IN
	(SELECT employee_id 
    FROM employees e 
    WHERE d.department_head_id = employee_id AND employee_salary < 5400);
-- Знайти відділи, де голова відділу має зарплатню меншу за 5400

SELECT d.department_name, et.ET_name
FROM departments d
CROSS JOIN expense_types et;
-- Показати всі потенційні комбінації відділів з лімітами відділів

SELECT 
    d.department_name, 
    CONCAT(e.employee_name, " ", e.employee_surname) AS department_head,
    SUM(er.ER_total) AS total_approved_expenses
FROM departments d
JOIN employees e ON d.department_head_id = e.employee_id
JOIN expense_reports er ON d.department_id = er.department_id
WHERE er.ER_accountant_approval = 1
GROUP BY d.department_name, e.employee_name, e.employee_surname;
-- Показати департаменти, їх керівників разом із сумами підтверджених витрат

SELECT * FROM departments d 
INNER JOIN employees e ON d.department_head_id = e.employee_id;
-- Показати інформацію про департаменти разом з інформацію про керівників цих департаментів

SELECT * FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id;
-- Показати інформацію про департаменти та їх працівників, включно з департаментами без працівників

SELECT * FROM departments d RIGHT JOIN employees e ON d.department_id = e.department_id;
-- Показати інформацію про департаменти та їх працівників, включно з працівниками не призначених до департаментів

 SELECT * FROM department_limits
 UNION
 SELECT * FROM expense_type_limits;
 -- Показати всі ліміти
 
 SELECT er.ER_id AS report_id,
    er.ER_date AS expense_date,
    CONCAT(e.employee_name, " ", e.employee_surname) AS employee_full_name,
    e.employee_birth_date AS Birth_Date
FROM expense_reports er
JOIN employees e ON er.employee_id = e.employee_id
WHERE MONTH(er.ER_date) = MONTH(e.employee_birth_date) AND DAY(er.ER_date) = DAY(e.employee_birth_date);
-- Знайти покупку, що була зроблена працівником в його день народження

-- 4)------------------------------------------------------------------------------------------------------------

SELECT DISTINCT et.ET_id,  et.ET_name, et.ET_description
FROM expense_reports er
JOIN expense_types et ON er.expense_type_id = et.ET_id
WHERE er.department_id = 1
AND MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE())
AND er.expense_type_id NOT IN
	(SELECT DISTINCT expense_type_id
	FROM expense_reports
	WHERE department_id = 2
	AND MONTH(ER_date) = MONTH(CURDATE()) AND YEAR(ER_date) = YEAR(CURDATE()));
-- В поточному місяці визначить види витрат по підрозділу Х, яких не було у підрозділу Y.

SELECT DISTINCT d.department_id, d.department_name
FROM expense_reports er
JOIN employees e ON er.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE())
AND expense_type_id NOT IN
	(SELECT DISTINCT expense_type_id
	FROM expense_reports
	WHERE MONTH(ER_date) = IF(MONTH(CURDATE()) = 1, 12, MONTH(CURDATE()) - 1)
    AND YEAR(ER_date) = IF(MONTH(CURDATE()) = 1, YEAR(CURDATE()) - 1, YEAR(CURDATE())));
-- Визначить відділи, співробітники яких здійснювали в поточному
-- календарному місяці витрати по певним видам, котрих не було минулого
-- календарного місяця (тобто в минулому місяці по цим видам витрат
-- відсутні чеки).