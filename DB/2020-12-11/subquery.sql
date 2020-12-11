/*
    SUB Query
    Query �ȿ� Query
    
    SELECT   ���� ROW ���� COLUM
    FROM     ���� ROW ���� COLUM
    WHERE    ���� ROW ���� COLUM
*/

-- SELECT
 SELECT employee_id, first_name,
 (SELECT first_name  FROM  employees WHERE employee_id = 100)
 FROM employees;
 -- COLUM 2�� , ROW 5��
  SELECT employee_id, first_name,
-- (SELECT first_name, last_name  FROM  employees WHERE job_id = 'IT_PROG') �������� ������
-- (SELECT first_name, last_name  FROM  employees WHERE employee_id = 100) �������� ������
(SELECT COUNT(*) FROM  employees)
 FROM employees;
 
-- FROM �Ѱ��ִ� �����͸� �� �޾���� �Ѵ�.
SELECT employee_iD, first_name, salary
FROM (SELECT employee_id, first_name, salary FROM employees);

SELECT EMPNO, first_name, salary
FROM (SELECT employee_id AS "EMPNO", first_name, salary
        FROM employees
        WHERE job_id = 'IT_PROG')
WHERE salary > 5000;
-- �μ���ȣ 50�� �޿��� 6000�̻��� ���
SELECT
    *
FROM employees
WHERE department_id = 50 AND salary > 6000;

SELECT
    *
FROM (SELECT * FROM employees 
        WHERE department_id = 50)
WHERE salary > 6000;

-- �޿��� �հ�, �ο���, �����, ����
/*
SELECT job_id, COUNT(*) -- ����� �Ұ�
FROM employees
GROUP BY job_id;
*/
SELECT e.first_name, e.salary, e.job_id, 
        j.job_id, j.salsum as "�޿� �հ�", j."�հ�" as "��"
FROM employees e, (SELECT job_id, SUM(salary) as salsum, COUNT(*) as "�հ�"
                        FROM employees
                        GROUP BY job_id) j
WHERE e.job_id = j.job_id;

-- where
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) from employees);

-- department_id = 90�� job_id
SELECT job_id, first_name, department_id
FROM employees
WHERE job_id in(SELECT job_id from employees where department_id = 90);

-- �μ����� ���� ������ ���� �޴� ����� ���� �޿��� �޴� ���
SELECT first_name, salary, department_id
FROM employees
WHERE salary in(SELECT MIN(salary) FROM employees
                GROUP BY department_id);
-- �μ����� ���� ������ ���� �޴� ������ ����
/*
SELECT department_id, MIN(salary), first_name -- ������
FROM employees
GROUP BY department_id;
*/
SELECT department_id, first_name,salary
FROM employees
WHERE (department_id, salary)  
        IN(SELECT  department_id , MIN(salary) FROM employees GROUP by department_id);
        
-- ����1) EMPLOYEES ���̺��� Kochhar�� �޿����� ���� ����� ������ ���
-- ��ȣ,�̸�,������,�޿��� ����϶�.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > (SELECT salary FROM employees
                    WHERE last_name = 'Kochhar');
--����2) EMPLOYEES ���̺��� �޿��� ��պ��� ���� ����� ������ �����ȣ,
--�̸�,������,�޿�,�μ���ȣ�� ����Ͽ���.
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE salary < (SELECT TRUNC(AVG(salary)) FROM employees );

--����3) EMPLOYEES ���̺��� 100�� �μ��� �ּ� �޿����� �ּ� �޿���
--���� �ٸ� ��� �μ��� ����϶�
SELECT department_id, MIN(SALARY)
FROM employees 
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary) FROM employees 
                        WHERE department_id = '100'
                        GROUP BY department_id);

--����4) �������� �ּ� �޿��� �޴� ����� ������ �����ȣ,�̸�,����,�μ���ȣ
--�� ����Ͽ���. �� �������� �����Ͽ���.
SELECT employee_id, last_name,salary, job_id, department_id
FROM employees 
where (job_id, salary) IN (SELECT job_id, MIN(salary) FROM employees
                        GROUP BY job_id)
ORDER BY job_id asc;

--����5) EMPLOYEES �� DEPARTMENTS ���̺��� ������ ���ϵ�� ����� ��
--���� �̸�,����,�μ���,�ٹ����� ����϶�.
SELECT e.last_name, e.job_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id 
    AND d.department_name IN(SELECT department_name FROM departments WHERE department_name = 'Sales');
    
SELECT e.first_name, e.job_id, d.department_name, d.location_id
FROM(SELECT first_name, job_id, department_id
FROM employees 
where job_id = 'SA_MAN') e, departments d
WHERE e.department_id = d.department_id;
    
--����6) EMPLOYEES ���̺��� ���� ���� ����� ���� MANAGER��
--�����ȣ�� ����϶�.
SELECT manager_id
FROM employees 
GROUP BY manager_id
HAVING COUNT(*) IN(SELECT MAX(COUNT(manager_id)) FROM employees GROUP BY manager_id);

SELECT manager_id
FROM (SELECT manager_id,COUNT(*) EMP_COUNT
        FROM employees
            GROUP BY manager_id)
WHERE EMP_COUNT = (SELECT MAX(COUNT(*))
                    from employees
                            GROUP BY MAnager_id);
SELECT A.MANAGER_ID
from (SELECT manager_id,COUNT(*) EMP_COUNT
        FROM employees
            GROUP BY manager_id) a
            INNER JOIN
(SELECT MAX(COUNT(*)) MAX_COUNT
                    from employees
                            GROUP BY MAnager_id) M
                on a.emp_count = m.max_count;
                
-- rownum
SELECT MANAGER_ID FROM(
SELECT manager_id, COUNT(*) EMP_COUNT
FROM employees
GROUP BY manager_id
ORDER BY EMP_COUNT desc)
WHERE ROWNUM = 1;

SELECT manager_id
from (SELECT ROW_NUMBER() OVER (ORDER BY COUNT(*) desc) row_count, manager_id, count(*)
    FROM employees
    GROUP by manager_id)
WHERE row_count = 1;/
--����7) EMPLOYEES ���̺��� ���� ���� ����� �����ִ�
--�μ���ȣ�� ������� ����϶�.

SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) IN (SELECT MAX(COUNT(employee_id)) FROM employees GROUP BY department_id);

--����8) EMPLOYEES ���̺��� �����ȣ�� 123�� ����� ������ ����
--�����ȣ�� 192�� ����� �޿�(SAL)���� ���� ����� �����ȣ, �̸�,
--����, �޿��� ����϶�.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id 
FROM employees WHERE employee_id = 123) 
and salary > (SELECT salary FROM employees 
                                    WHERE employee_id = 192);
                                    
--����9) ����(JOB)���� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ��
--��, �μ����� ����϶�.
-- ����1 : �������� �������� ����
SELECT e.employee_id, e.last_name, e.job_id,
        d.department_name
FROM employees e INNER JOIN departments d
    on e.department_id = d.department_id
where (e.job_id, e.salary) 
IN(SELECT job_id, MIN(salary)
FROM employees GROUP BY job_id )
ORDER BY e.job_id DESC;

--����10) EMPLOYEES ���̺��� �������� �ּ� �޿��� ���� �޿��� �޴� ����� ������ ��
--����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ�� ����϶�
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
where salary IN(SELECT  MIN(salary)
FROM employees 
GROUP BY job_id);

--����11) EMPLOYEES ���̺��� 50�� �μ��� �ּ� �޿��� �޴� ��� ���� ��
--�� �޿��� �޴� ����� ������ �����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ��
--����϶�. �� 50���� ����
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees WHERE
                department_id = 50) and department_id <> 50;
                
--����12) EMPLOYEES ���̺��� 50�� �μ��� �ְ� �޿��� �޴� ��� ����
--���� �޿��� �޴� ����� ������ �����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ��
--����϶�. ��50���� ����
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE
                department_id = 50
                GROUP BY department_id) and department_id <> 50;
--����13) �ֱ� �Ի��� ��� ������ �ۼ��ؼ� 1 ~ 10��°, 11 ~ 20 ����� ����
--�� ����Ͻÿ�
SELECT ROWNUM, hire_date, job_id, last_name
FROM (
        SELECT hire_date, job_id, last_name
        FROM employees
        ORDER BY hire_date desc)
WHERE ROWNUM BETWEEN 1 AND 20;