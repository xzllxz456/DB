-- DML
-- insert delete select(90%�̻� ��� �߿�) update
/*
    Query
            Dao         <- Datebase(Container)
                list <--- file
                save ---> file
            Dto
    SELECT
        (��, COLUMN, �Լ�, SUB QUERY)
    FROM
        (TABLE��, SUB QUERY)    
*/
SELECT 1 FROM DUAL;

SELECT * FROM employees;
SELECT employee_id, FIRST_NAME, SALARY
FROM employees;

SELECT employee_id, first_name, SALARY
FROM employees;
-- Alias ����
SELECT employee_id AS �����ȣ, first_name as "�� ��", SALARY"����"
FROM employees;-- as�� ��������

-- || ���ڿ� ���ϱ�
SELECT employee_id || first_name || SALARY
FROM employees;
SELECT first_name, last_name, salary, salary*12 as "����"
FROM employees;

