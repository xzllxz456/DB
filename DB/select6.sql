/*
    SUM, AVG, COUNT, MAX, MIN ���� ���
*/
SELECT COUNT(salary), SUM(salary),AVG(salary), SUM(salary)/COUNT(salary)
FROM employees
WHERE job_id = 'IT_PROG';

/*
SELECT employee_id, COUNT(salary), SUM(salary)
FROM employees;-- �Ϲ� �÷��ϰ� ��� ��� �Ұ�
WHERE job_id = 'IT_PROG';
*/

/*
    GROUP BY, HAVING
*/
SELECT DISTINCT department_id -- �÷����ξ���
FROM employees
ORDER BY department_id ASC; -- �ߺ�����

SELECT department_id
FROM employees
GROUP BY department_id; -- �׷����� ���δ�
-- ORDER BY department_id ASC;
/*
SELECT job_id, employee_id -- �׷����� ������ �Ѹ��Ѹ� ǥ���� �Ұ����ϱ⶧���� ��� �Ұ�
FROM employees
GROUP BY job_id;
*/

SELECT job_id, SUM(salary), AVG(salary)
FROM employees
GROUP BY job_id
HAVING SUM(salary) >= 10000;     -- ������     -- GROUP BY���� �ݵ�� �ʿ�

/*
    NVL(����� �Ǵ� �÷�, ������) NUMBER
    ����� �Ǵ� �÷� != NULL   --> ����� �Ǵ� �÷�
    ����� �Ǵ� �÷� == NULL   --> ������
*/

SELECT first_name, NVL(commission_pct,0)
FROM employees;

/*
    NVL2(����� �Ǵ� �÷�, ��1, ��2)
    ����� �Ǵ� �÷� != NULL      --> ��1
    ����� �Ǵ� �÷� == NULL      --> ��2
*/

SELECT first_name, NVL2(commission_pct, 1, 0)
FROM employees;

-- �޿��� 5000�̻� �޴� ��������� �հ踦 ���� ������ �׷�ȭ�Ͽ� �޿� �հ谡 2000�� �ʰ��ϴ� �������� ���϶�.
SELECT job_id, SUM(salary)
FROM employees
WHERE salary >= 5000
GROUP BY job_id
HAVING SUM(salary) > 20000;

SELECT job_id, count(salary), sum(salary), round(avg(salary))
FROM employees
WHERE salary > 5000
GROUP BY job_id
HAVING SUM(salary) > 20000;

--����1) EMPLOYEES ���̺��� King�� ������ �ҹ��ڷ� �˻��ϰ� �����ȣ,
--����, ������(�ҹ��ڷ�),�μ���ȣ�� ����϶�.
SELECT employee_id, last_name, LOWER(job_id), department_id
FROM employees
WHERE LOWER(last_name) LIKE LOWER('king');

--����2) EMPLOYEES ���̺��� King�� ������ �빮�ڷ� �˻��ϰ� �����ȣ,
--����, ������(�빮�ڷ�),�μ���ȣ�� ����϶�.
SELECT employee_id, last_name, UPPER(job_id), department_id
FROM employees
WHERE UPPER(last_name) LIKE UPPER('KING');

-- ����3) DEPARTMENTS ���̺��� �μ���ȣ�� �μ��̸�, �μ��̸��� ��ġ��
-- ȣ�� ���Ͽ� ����ϵ��� �϶�.
SELECT department_id || ' ' ||department_name,department_name|| ' '||location_id,
    CONCAT(department_id, department_name),
    CONCAT(department_name, location_id)
FROM departments;

--����4) EMPLOYEES ���̺��� �̸��� ù ���ڰ� ��K�� ���� ũ�� ��Y������ ����
--����� ������ �����ȣ, �̸�, ����, �޿�, �μ���ȣ�� ����϶�.
--�� �̸������� �����Ͽ���.

SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE last_name > 'K%' AND last_name < 'Y%'
ORDER BY last_name asc;

SELECT Employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE SUBSTR(last_name, 1, 1) > 'K' AND SUBSTR(last_name, 1, 1) < 'Y'
ORDER BY last_name asc;
--����5) EMPLOYEES ���̺��� 20�� �μ� �� �̸��� ���� �� �޿��� �ڸ���
--�� �����ȣ, �̸�, �̸��� �ڸ���, �޿�, �޿��� �ڸ����� ����϶�.

SELECT department_id, employee_id, last_name, LENGTH(last_name), salary, LENGTH(salary)
FROM employees
WHERE department_id = 20;

-- ����6) EMPLOYEES ���̺��� �̸� �� ��e������ ��ġ�� ����϶�.
SELECT last_name, INSTR(last_name, 'e'),INSTR(last_name, 'e',1,2)
FROM employees;

SELECT first_name, INSTR(first_name, 'e'),INSTR(first_name, 'e',1,2)
FROM employees;
-- ����7) ������ ������ �����ϰ� ����� �м��϶�.

SELECT ROUND(4567.678),ROUND(4567.678,0), -- �ݿø� �ؼ� �ڸ� ,2�� �Ҽ��� 2��, -2�� ������ 2��
ROUND(4567.678,2),ROUND(4567.678,-2)
FROM dual;

--����8) EMPLOYEES ���̺��� �μ���ȣ�� 80�� ����� �޿��� 30���� ����
-- �������� ���Ͽ� ����϶�.
SELECT department_id, round(salary/30, 5)
FROM employees
WHERE department_id = 80;

SELECT first_name,salary, MOD(salary,30), department_id
FROM employees
WHERE department_id = 80;

--����9) EMPLOYEES ���̺��� 30�� �μ� �� �̸��� ��� ������ �����Ͽ�
--����Ͽ���. �� ��� ������ �� �� �Ʒ��� ����϶�.
--���̱⿣ ����ó�� �������� �׸��带 ���� Ŭ���ϸ� ���� �Ǿ��ٴ� ���� Ȯ���� �� �ֽ��ϴ�.
SELECT employee_id, last_name, job_id, last_name || CHR(10) || job_id
FROM employees
WHERE department_id like 30;

--����10) EMPLOYEES ���̺��� ������� �ٹ��� ���� ���� ���� �ΰ��� ��
--���Ͽ���. �� �ٹ� �ϼ��� ���� ��� ������ ����Ͽ���.
SELECT last_name, round ((SYSDATE-hire_date)/7,0) "��", round (SYSDATE-hire_date) "��"
FROM employees
ORDER BY SYSDATE-hire_date DESC;

SELECT first_name, hire_date, 
    to_date(SYSDATE) - hire_date AS "�� �ٹ� �ϼ�",    -- �Ի��� �Ŀ� �� �ϰ� �ٹ� �ߴ���? 
    trunc( (to_date(SYSDATE) - hire_date) / 7) AS "�� �ٹ� ���ϼ�",   -- �Ի��� �Ŀ� �� �ְ� �ٹ� �ߴ���?  
    mod( (to_date(SYSDATE) - hire_date), 7) as "���� �ϼ�" 
  
FROM employees 
ORDER BY "�� �ٹ� �ϼ�" DESC;

SELECT last_name, hire_date, SYSDATE,
    trunc(SYSDATE - hire_date),  -- �����Լ�
    trunc((SYSDATE - hire_date)/7), -- �� �ٹ� ��
      ROUND(MOD((SYSDATE - hire_date), 7)) -- �ѱٹ��ϼ� - �ѱٹ��� = �������ϼ�
FROM employees
ORDER BY SYSDATE - hire_date DESC;

-- ����11) EMPLOYEES ���̺��� �μ� 50���� �޿� �տ� $�� �����ϰ� 3�ڸ�
-- ���� ,�� ����϶�
SELECT department_id, last_name,salary, TO_CHAR( salary, '$999,999,999')
FROM employees
WHERE department_id = 50;

--����1) EMPLOYEES ���̺��� ������ ��� SA�� ���Ͽ� �޿��� ���, �ְ��, ������, �հ踦 ���Ͽ� ����Ͽ���.
SELECT job_id, AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
GROUP BY job_id;

--����2) EMPLOYEES ���̺��� �μ����� �ο���, ��� �޿�, �����޿�, �ְ� �޿�, �޿��� ���� ���Ͽ� ����϶�.
SELECT job_id, COUNT(job_id),AVG(salary), MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY job_id;

--����3) EMPLOYEES ���̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ���Ͽ� ����Ͽ���.
SELECT job_id, department_id, COUNT(job_id), SUM(salary)
FROM employees
GROUP BY department_id, job_id
HAVING COUNT(job_id) > 4;

--����4) EMPLOYEES ���̺��� �޿��� �ִ� 10000�̻��� �μ��� ���ؼ� �μ���ȣ, ��� �޿�, �޿��� ���� ���Ͽ� ����Ͽ���.
SELECT department_id, SUM(salary), ROUND(AVG(SALARY))
FROM employees
GROUP BY department_id
HAVING MAX(salary) >= 10000;


--����5) EMPLOYEES ���̺��� ��ü ������ 10000�� �ʰ��ϴ� �� ������ ���ؼ� ������ ���޿� �հ踦 ����϶�. 
--�� �Ǹſ�(SA)�� �����ϰ� �� �޿� �հ�� ����(��������)�϶�.
SELECT job_id,COUNT(*), SUM(salary), AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) > 10000;

