-- �����ȸ
SELECT
    *
FROM employees;

-- Į�� ��ȸ �ϱ�
    SELECT * FROM USER_TAB_COLUMNS;
-- ��� ��ȣ, �̸�, �޿�, ������ ���
SELECT employee_id, FIRST_NAME, SALARY, JOB_ID
FROM employees;
--��� �������� �޿��� $300���� ��Ű�� ���ؼ� ���� �����ڸ� ���
-- ����� SALATY + 300�� ���÷���
SELECT FIRST_NAME, SALARY, SALARY+300
FROM employees;
--EMP ���̺��� �����ȣ, �̸�, �޿�, ���ʽ�, ���ʽ� �ݾ��� �����
--����. (����� ���ʽ��� ���� + (����*Ŀ�̼�))
SELECT employee_id, FIRST_NAME, SALARY, COMMISSION_PCT*SALARY, SALARY+(COMMISSION_PCT*SALARY)
FROM employees;
--EMPLOYEES ���̺��� LAST_NAME�� �̸����� SALARY�� �޿��� ����Ͽ���.

SELECT LAST_NAME "�̸�", SALARY "�޿�"
FROM employees;

--EMPLOYEES ���̺��� LAST_NAME�� Name���� 
--SALARY *12�� Annual Salary(����)�� ����Ͽ���
SELECT LAST_NAME "Name", SALARY*12 "Annual Salary"
FROM employees;
--EMPLOYEES ���̺��� �̸��� ������ �����Ͽ� ����Ͽ���.
SELECT LAST_NAME || JOB_ID "emploryees"
FROM employees;

--EMPLOYEES ���̺��� �̸��� ������
--��KING is a PRESIDENT�� �������� ����Ͽ���.
SELECT LAST_NAME || ' is a JOB_ID' "Emploryees Details"
FROM employees;

--����11) EMPLOYEES ���̺��� �̸��� ������
--��KING: 1 Year salary = 60000�� �������� ����Ͽ���.

SELECT LAST_NAME || ': 1 Year salary = ' || SALARY*12 "MONTHLY"
FROM employees;

SELECT job_id
FROM employees;