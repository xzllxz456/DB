/*
    ���� �Լ�
    RANK()          1 2 3 3 5 6
    DENSE_RANK()    1 2 3 3 4 5
    ROW_NUMBER()    1 2 3 4 5 6
    ROWNUM              "
    
    BBS -> �Խ���  
*/

SELECT employee_id, first_name
FROM employees
WHERE employee_id >= 100 AND employee_id <= 109;

-- OVER() 
-- select�������� ���
-- GROUP BY �� �����ϱ� ���ؼ� �ۼ��� �Լ�
SELECT department_id, COUNT(*)
FROM employees;

SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id, COUNT(*)OVER()
FROM employees;

SELECT department_name, COUNT(*)OVER( PARTITION BY department_id )
FROM departments;



SELECT first_name, 
    RANK()OVER( ORDER BY salary DESC ) as RANK,
    DENSE_RANK()OVER( ORDER BY salary DESC ) as RANK,
    ROW_NUMBER()OVER( ORDER BY salary DESC ) as RANK
FROM employees;

-- ROWNUM
SELECT ROWNUM, employee_id, first_name
FROM employees
WHERE ROWNUM <= 10;

SELECT ROWNUM, employee_id, first_name  -- 2
FROM employees
WHERE ROWNUM > 10 AND ROWNUM <= 20; -- 1

-- 1. ������ ����
-- 2. ��ȣ�� �Ҵ�
-- 3. ������ ����
SELECT RNUM, employee_id, first_name, salary                    -- 3
FROM (SELECT ROWNUM as RNUM, employee_id, first_name, salary    -- 2 
        FROM (  SELECT employee_id, first_name, salary      -- 1
            FROM employees
            ORDER BY salary DESC)
        )
WHERE RNUM >= 11 AND RNUM <= 20;












