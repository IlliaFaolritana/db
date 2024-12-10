use DBDataBase;

SELECT d.department_id, d.department_name,
	COUNT(e.employee_id) AS employee_count
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
-- Знайти кількість співробітників у кожному відділі

SELECT d.department_id, d.department_name,
    SUM(er.ER_total) AS total_expenses
FROM expense_reports er
JOIN departments d ON d.department_id = er.department_id
WHERE MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE())
GROUP BY d.department_id, d.department_name;
-- Знайти витрати кожного відділу за поточний місяць

SELECT d.department_id, d.department_name, et.ET_name,
    SUM(er.ER_total) AS total_expenses
FROM expense_reports er
JOIN departments d ON d.department_id = er.department_id
JOIN expense_types et ON er.expense_type_id = et.ET_id
WHERE MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE())
GROUP BY d.department_id, d.department_name, et.ET_name;
-- Знайти витрати кожного відділу по видам за поточний місяць

SELECT d.department_id, d.department_name, dl.DL_amount,
	SUM(er.ER_total) AS total_expenses
FROM expense_reports er
JOIN departments d ON d.department_id = er.department_id
JOIN department_limits dl ON dl.DL_id = d.department_limit_id
WHERE MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE())
GROUP BY d.department_id, d.department_name, dl.DL_amount
HAVING total_expenses > dl.DL_amount;
-- Знайти підрозділи, що не вклалися в місячний ліміт поточного місяця
    
SELECT SUM(er.ER_total) AS total_expenses
FROM expense_reports er
WHERE MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE())
HAVING total_expenses > 15000;
-- Знайти загальні витрати поточного місяця, якщо вони перевищують 15000

SELECT CONCAT(e.employee_name, " ", e.employee_surname) AS full_name,
	d.department_name, er.ER_total,
    ROW_NUMBER() OVER (PARTITION BY e.department_id ORDER BY er.ER_total DESC) AS row_num
FROM expense_reports er
JOIN employees e ON e.employee_id = er.employee_id
JOIN departments d ON d.department_id = e.department_id
WHERE MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE());
-- Показати рейтинг працівників по найбільшим разовим покупкам по департаментам поточного місяця

SELECT d.department_name,
    GROUP_CONCAT(e.employee_name ORDER BY e.employee_name ASC SEPARATOR ', ') AS employee_list
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;
-- Отримати список імен співробітників у кожному відділі через кому
    
SELECT d.department_id, d.department_name,
	SUM(er.ER_total) AS total_expenses
FROM expense_reports er
JOIN departments d ON d.department_id = er.department_id
WHERE MONTH(ER_date) = IF(MONTH(CURDATE()) = 1, 12, MONTH(CURDATE()) - 1)
AND YEAR(ER_date) = IF(MONTH(CURDATE()) = 1, YEAR(CURDATE()) - 1, YEAR(CURDATE()))
GROUP BY d.department_id, d.department_name  
ORDER BY total_expenses DESC, d.department_id ASC;
-- Визначить відділи з найбільшими витратами за поточний місяць

SELECT d.department_id, d.department_name, dl.DL_amount,
	SUM(er.ER_total) AS total_expenses
FROM expense_reports er
JOIN departments d ON d.department_id = er.department_id
JOIN department_limits dl ON dl.department = d.department_id
WHERE MONTH(ER_date) = IF(MONTH(CURDATE()) = 1, 12, MONTH(CURDATE()) - 1)
AND YEAR(ER_date) = IF(MONTH(CURDATE()) = 1, YEAR(CURDATE()) - 1, YEAR(CURDATE()))
AND MONTH(dl.DL_end_date) = IF(MONTH(CURDATE()) = 1, 12, MONTH(CURDATE()) - 1)
AND YEAR(dl.DL_end_date) = IF(MONTH(CURDATE()) = 1, YEAR(CURDATE()) - 1, YEAR(CURDATE()))
GROUP BY d.department_id, d.department_name, dl.DL_amount
HAVING total_expenses > dl.DL_amount;
-- Знайти підрозділи, що не вклалися в місячний ліміт витрат минулого місяця

SELECT d.department_id, d.department_name,
	SUM(er.ER_total) AS total_expenses
FROM expense_reports er
JOIN departments d ON d.department_id = er.department_id
WHERE (MONTH(ER_date) = IF(MONTH(CURDATE()) = 1, 12, MONTH(CURDATE()) - 1)
AND YEAR(ER_date) = IF(MONTH(CURDATE()) = 1, YEAR(CURDATE()) - 1, YEAR(CURDATE())))
OR (MONTH(er.ER_date) = MONTH(CURDATE()) AND YEAR(er.ER_date) = YEAR(CURDATE()))
GROUP BY d.department_id, d.department_name  
ORDER BY total_expenses DESC, d.department_id;
-- Визначить відділи з найбільшими витратами за минулі два місяця