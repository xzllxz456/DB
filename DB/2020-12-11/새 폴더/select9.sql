/*  
    ���� �Լ�
    RANK()          1 2 3 3 5 6   1 2 3 3 3 6  ������ ���� �ߺ�ó��
    DENSE RANK()    1 2 3 3 4 5   1 2 3 3 3 5
    ROW_NUMBER()    1 2 3 4 5 6     �������
    ROWNUM          1 2 3 4 5 6     �������
    
    BBS -> �����  �ֽű� ���� �ø���
*/

SELECT employee_id, first_name
FROM employees
WHERE employee_id >= 100 AND employee_id <= 109;

--OVER()  -- ���� ���������
-- select �������� ���
-- GROUP BY �� �����ϱ� ���ؼ� �ۼ��� �Լ�
SELECT department_id, COUNT(*)OVER()
FROM employees;

SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_name, COUNT(*)OVER(PARTITION BY department_id)
FROM departments;

SELECT first_name, 
        RANK()OVER(ORDER BY salary desc) as RAMK,
        DENSE_RANK()OVER(ORDER BY salary desc) as danseRAMK,
        ROW_NUMBER() OVER(ORDER BY salary desc) as rowRAMK
FROM employees;
SELECT first_name, RANK()OVER(ORDER BY salary ASC)
FROM employees;

-- ROWNUM
SELECT ROWNUM, employee_id, first_name
FROM employees
WHERE ROWNUM <= 10;

SELECT ROWNUM, employee_id, first_name --2
FROM employees
WHERE ROWNUM > 10 or ROWNUM < 20; --1 �ȵȴ�
-- 1, ������ ����
-- 2. ��ȣ�� �Ҵ�
-- 3. ������ ����
SELECT rnum, employee_id, first_name, salary
FROM (SELECT ROWNUM as rnum, employee_id, first_name, salary  --2
    FROM (  SELECT employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC) )
WHERE rnum >= 11 AND rnum <= 20;

--����13) �ֱ� �Ի��� ��� ������ �ۼ��ؼ� 1 ~ 10��°, 11 ~ 20 ����� ����
--�� ����Ͻÿ�
SELECT rnum, hire_date, job_id, last_name
FROM(
    SELECT ROWNUM as rnum, hire_date, job_id, last_name
        FROM (
            (SELECT hire_date, job_id, last_name
            FROM employees
            ORDER BY hire_date desc)
        )
        )
        where rnum < 20;
        
