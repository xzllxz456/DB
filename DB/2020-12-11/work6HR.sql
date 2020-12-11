/*
    Join : �ΰ� �̻��� ���̺��� �����ؼ� �����͸� ���
    
    inner Join
    full outer Join
    cross Join
    outer Join
        left Join
        right Join
    self Join : ���� ���̺� �������
*/

SELECT e.first_name, d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
    and e.job_id = j.job_id
        and e.first_name = 'Lex';
        
SELECT emp.first_name as "������",mag.first_name as "����"
FROM employees emp, employees mag
WHERE emp.manager_id = mag.manager_id;

--����1) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian
--Product(��� ������ ����� Join)�Ͽ� �����ȣ,�̸�,����,�μ���ȣ,�μ���, �ٹ����� ����Ͽ���. 
--cross
SELECT e.employee_id, e.first_name, e.job_id, e.department_id,
        d.department_id, d.department_name,d.location_id
FROM employees e CROSS JOIN departments d;

--����2) EMPLOYEES ���̺��� �����ȣ,�̸�,����, EMPLOYEES ���̺���
--�μ���ȣ, DEPARTMENTS ���̺��� �μ���ȣ,�μ���,�ٹ����� ����Ͽ���.
SELECT e.employee_id, e.first_name, e.job_id,
e.department_id, d.department_id, d.department_name,d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, e.first_name, e.job_id,
e.department_id, d.department_id, d.department_name,d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;
    
-- ����3) Alexander Hunold �� �μ����� ����϶�.
SELECT e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    and e.first_name = 'Alexander'
    and e.last_name = 'Hunold';
    
--����4) ������ �μ����� �ٹ��ϰ� �ִ� ������� ����϶�.
SELECT d.department_name, e.first_name, e.last_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    and d.department_name = 'Sales';
    
 --   ����5) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ�
--SA_MAN ������� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����϶�.
--(Alias�� ���)
SELECT e.employee_id, e.first_name, e.salary,
d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
 and e.job_id = 'SA_MAN';
 
--����6) EMPLOYEES ���̺�� DEPARTMENTS ���̺��� DEPARTMENTS ��
--�̺� �ִ� ��� �ڷḦ �����ȣ,�̸�,����, EMPLOYEES ���̺��� �μ���
--ȣ, DEPARTMENTS ���̺��� �μ���ȣ,�μ���,�ٹ����� ����Ͽ���
--(Outer Join)

SELECT e.department_id, e.first_name, e.job_id,
    d.department_name, d.location_id
FROM departments d, employees e
WHERE d.department_id = e.department_id(+)
UNION
SELECT e.department_id, e.first_name, e.job_id,
    d.department_name, d.location_id
FROM departments d, employees e
WHERE d.department_id(+) = e.department_id;

SELECT e.department_id, e.first_name, e.job_id,
    d.department_name, d.location_id
FROM departments d full outer join employees e
on d.department_id = e.department_id;

-- ����7) EMPLOYEES ���̺��� Self join�Ͽ� ������(�Ŵ���)�� ����Ͽ���.
SELECT concat( e.first_name , '�� ����'), concat( m.first_name, '�Դϴ�')
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

--����8) EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)�� ����ϰ�
--�Ŵ��� ���̵� ���� ����� �����ϰ� ��������� �ϸ�, �޿��� �������� ����϶�.
SELECT e.employee_id, e.first_name, e.manager_id, m.employee_id,
m.first_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+)
--    and e.manager_id is not null
start with e.manager_id is not null
CONNECT by e.manager_id = PRIOR e.employee_id
ORDER by e.salary DESC;
--����9) EMPLOYEES ���̺��� right join�Ͽ� ������(�Ŵ���)�� 108��
--��������� �޿��� �������� ����϶�.
SELECT e.employee_id, e.first_name, e.salary,
    e.manager_id, m.employee_id, m.first_name
FROM employees e, employees m
WHERE e.manager_id(+) = m.employee_id
    and e.manager_id = '108'
CONNECT BY prior e.manager_id = e.employee_id
ORDER by e.salary DESC;


