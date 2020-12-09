/*
    Join -- �ٸ� ���̺��� ������ ������������
    �ΰ� �̻��� ���̺��� �����ؼ� �����͸� �˻��ϴ� ���.
    ���� �ΰ��̻��� ��(low)���� ����� �� primary key(�⺻Ű) Foreign Key(�ܷ�Ű)����
    ����ؼ� ����
    
    primary Key(�⺻Ű) : ���̺��� �ߺ����� �ʴ� Ű
    Foreign Key(�ܷ�Ű) : �ٸ� ���̺� �ִ� Ű
    
    Ansi SQL ����
    Oracle ����
    
    inner Join : ���� ���� �߿�  
    full outer Join
    cross Join
    outer
        left Join : �߿�
        right Join : �߿�
    self Join : ���� �߿�
*/

-- inner Join -- ������
-- Ansi SQL
SELECT e.employee_id, first_name,  --���ʿ� �ִ°� ��þ��ص� �����ȳ�
        d.department_id, e.department_id,
        d.department_name
FROM employees e INNER JOIN departments d 
    ON e.department_id = d.department_id;
--Oracle SQL
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- full outer Join -- ������
-- ansi
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e FULL OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- cross Join ������
-- oracle
SELECT e.department_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e, departments d;

-- Outer Join -������
-- left, right
-- Ansi
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e LEFT OUTER JOIN departments d
   ON e.department_id = d.department_id;
   
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e RIGHT OUTER JOIN departments d
   ON e.department_id = d.department_id;
-- Oracle -- (+ ���ִ°ſ��� ���� ����)
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);
--                 <--   left join
--WHERE e.department_id(+) = d.department_id;  right join

SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)
        AND e.department_id IS NULL;
        
-- self Join : ������ ���̺� Join
SELECT a.employee_id, a.first_name,
        a.manager_id, b.employee_id,
        b.first_name
FROM employees A, employees B -- A: ������̺� B: ������̺�
WHERE A.manager_id = B.employee_id;

-- ������ ���� ����, ���� ����
SELECT a.employee_id, a.first_name,
        a.manager_id as "����� ���", b.employee_id,
        b.first_name as "����� �̸�"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)
--CONNECT BY PRIOR a.manager_id = a.employee_id; --�����
CONNECT BY  a.manager_id = PRIOR a.employee_id; -- �����

-- ������ ���� ����, ����
SELECT A.EMPLOYEE_ID, LPAD(' ', (LEVEL-1)*2) || A.FIRST_NAME, A.MANAGER_ID, B.EMPLOYEE_ID, B.FIRST_NAME
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID(+)
CONNECT BY  A.MANAGER_ID = PRIOR A.EMPLOYEE_ID; -- �����

SELECT COUNT(manager_id) FROM employees;
SELECT COUNT(*) FROM employees
WHERE manager_id IS NOT NULL;

-- �� ������ �����̸�(���Ӹ� ����)�� �μ���ȣ, �μ���, �μ��� �����ȣ�� ����غ��ÿ�~
SELECT e.first_name || e.last_name as "�� ��", 
        j.job_title, e.department_id, d.department_name, l.postal_code
FROM employees e, departments d, locations l, jobs j
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.job_id = j.job_id;

SELECT e.first_name || e.last_name as "�� ��", 
        j.job_title, e.department_id, d.department_name, l.postal_code
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
        INNER JOIN locations l ON l.location_id = d.location_id
        INNER JOIN  jobs j ON j.job_id = e.job_id;
        
-- ����1) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian
-- Product(��� ������ ����� Join)�Ͽ� �����ȣ,�̸�,����,�μ���ȣ,�μ���,
-- �ٹ����� ����Ͽ���.
SELECT e.employee_id, e.first_name|| ' ' || e.last_name, e.job_id,
e.department_id,d.department_name,d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, e.first_name|| ' ' || e.last_name, e.job_id,
e.department_id,d.department_name,d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;

-- ����2) EMPLOYEES ���̺��� �����ȣ,�̸�,����, EMPLOYEES ���̺���
-- �μ���ȣ, DEPARTMENTS ���̺��� �μ���ȣ,�μ���,�ٹ����� ����Ͽ���.
SELECT e.employee_id, e.last_name, e.job_id, e.department_id, 
d.department_id, d.department_name, d.location_id

FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, e.last_name, e.job_id, e.department_id, 
d.department_id, d.department_name, d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;
    
--    ����3) Alexander Hunold �� �μ����� ����϶�.
SELECT e.first_name, e.last_name, e.department_id,
d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.first_name like 'Alexander'
    AND e.last_name like 'Hunold';

SELECT e.first_name, e.last_name, e.department_id,
d.department_id, d.department_name
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.first_name like 'Alexander'
    AND e.last_name like 'Hunold';
    
-- ����4) ������ �μ����� �ٹ��ϰ� �ִ� ������� ����϶�.
SELECT e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND d.department_name like 'Sales';
    
SELECT e.first_name, d.department_id, d.department_name
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_name like 'Sales';

-- ����5) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ�
-- SA_MAN ������� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����϶�.
-- (Alias�� ���)
SELECT e.employee_id, e.first_name||' '||e.last_name, e.salary,
d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.job_id like 'SA_MAN';
    
SELECT e.employee_id, e.first_name||' '||e.last_name, e.salary,
d.department_name, d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.job_id = 'SA_MAN';

-- ����6) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� DEPARTMENTS ��
-- �̺� �ִ� ��� �ڷḦ �����ȣ,�̸�,����, EMPLOYEES ���̺��� �μ���
-- ȣ, DEPARTMENTS ���̺��� �μ���ȣ,�μ���,�ٹ����� ����Ͽ��� (Outer Join)
SELECT e.employee_id, e.first_name||' '||e.last_name, e.job_id,
    e.department_id,
d.department_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;

SELECT e.employee_id, e.first_name||' '||e.last_name, e.job_id,
    e.department_id,
d.department_id, d.department_name, d.location_id
FROM employees e RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;
    
-- ����7) EMPLOYEES ���̺��� Self join�Ͽ� ������(�Ŵ���)�� ����Ͽ���.

SELECT a.last_name|| ' �����ڴ�'|| b.last_name
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;

SELECT a.last_name|| '�� �����ڴ�' || b.last_name
FROM employees a INNER JOIN employees b
    ON a.manager_id = b.employee_id;
    
-- ����8) EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)�� ����ϰ�
-- �Ŵ��� ���̵� ���� ����� �����ϰ� ��������� �ϸ�, �޿��� �������� ����϶�.
SELECT a.employee_id ,a.first_name,
a.manager_id, b.employee_id, b.first_name
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)
START WITH a.manager_id IS NOT NULL
CONNECT BY  a.manager_id = PRIOR a.employee_id
ORDER BY a.salary DESC;

SELECT
    *
FROM employees a LEFT OUTER JOIN employees b
    ON a.manager_id = a.employee_id
START WITH a.manager_id IS NOT NULL
CONNECT BY  a.manager_id = PRIOR a.employee_id
ORDER BY a.salary DESC;