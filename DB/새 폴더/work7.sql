-- ����1) EMPLOYEES ���̺��� (Kochhar�� �޿�)���� ���� ����� ������ �����ȣ,�̸�,������,�޿��� ����϶�.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > (SELECT salary 
                FROM employees 
                WHERE last_name = 'Kochhar');
                
-- ����2) EMPLOYEES ���̺��� (�޿��� ���)���� ���� ����� ������ �����ȣ,�̸�,������,�޿�,�μ���ȣ�� ����Ͽ���.  
SELECT employee_id, first_name, job_id, department_id, salary
FROM employees
WHERE salary < (SELECT AVG(salary) 
                FROM employees);

-- ����3) EMPLOYEES ���̺��� (100�� �μ��� �ּ� �޿�)���� �ּ� �޿��� ���� �ٸ� ��� �μ��� ����϶�
-- �׷��Լ� -> ���
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (  SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = 100);

-- ����4) (�������� �ּ� �޿�)�� �޴� ����� ������ �����ȣ,�̸�,����,�μ���ȣ�� ����Ͽ���. 
-- �� �������� �����Ͽ���.
SELECT employee_id, first_name, job_id, department_id, salary
FROM employees
WHERE (job_id, salary) IN(  SELECT job_id, MIN(salary) 
                            FROM employees 
                            GROUP BY job_id);

-- ����5) EMPLOYEES �� DEPARTMENTS ���̺��� ������ SA_MAN ����� ������ �̸�,����,�μ���,�ٹ����� ����϶�.
-- from��
SELECT e.first_name, e.job_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.job_id = 'SA_MAN';

SELECT e.first_name, e.job_id, d.department_name, d.location_id
FROM (  SELECT first_name, job_id, department_id
        FROM employees
        WHERE job_id = 'SA_MAN' ) e, departments d
WHERE e.department_id = d.department_id;

-- ����6) EMPLOYEES ���̺��� (���� ���� ����� ��)�� ���� MANAGER�� �����ȣ�� ����϶�.
SELECT manager_id, COUNT(*)
FROM employees
GROUP BY manager_id
HAVING COUNT(manager_id) = (SELECT MAX( COUNT(*) )
                            FROM employees
                            GROUP BY manager_id);


-- ����7) EMPLOYEES ���̺��� (���� ���� �����)�� ���� �ִ� �μ� ��ȣ�� �������  ����϶�.
SELECT department_id, COUNT(department_id)
FROM employees
GROUP BY department_id
HAVING COUNT(department_id) = ( SELECT MAX(COUNT(*))
                                FROM employees
                                GROUP BY department_id);

-- ����8) EMPLOYEES ���̺��� (�����ȣ�� 123�� ����� ����)�� ���� (�����ȣ�� 192�� ����� �޿�(SAL))���� ���� ����� 
-- �����ȣ,�̸�,����,�޿��� ����϶�.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 123)   -- �����ȣ�� 123�� ����� ���� ST_MAN
    AND salary > (SELECT salary FROM employees WHERE employee_id = 192); -- �����ȣ�� 192�� ����� �޿�(SAL) 4000


-- ����9)(����(JOB)���� �ּұ޿�)�� �޴� ����� ������ �����ȣ,�̸�,����,�μ����� ����϶�.
-- ����1 :�������� ������������
SELECT employee_id, last_name, job_id, salary, d.department_name
FROM employees e, departments d
WHERE (job_id, salary)IN(  SELECT job_id, MIN(salary)
                            FROM employees
                            GROUP BY job_id )
    AND e.department_id = d.department_id
ORDER BY salary DESC;

-- ����10) EMPLOYEES ���̺��� �������� �ּ� �޿��� ���� �޿��� �޴� ����� ������ �����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ�� ����϶�
SELECT employee_id, last_name, job_id, salary, d.department_name
FROM employees e, departments d
WHERE salary IN(  SELECT MIN(salary)
                            FROM employees
                            GROUP BY job_id )
    AND e.department_id = d.department_id;


-- ����10) EMPLOYEES ���̺��� (50�� �μ��� �ּ� �޿�)�� �޴� ������� ���� �޿��� �޴� ����� ������ 
-- �����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ�� ����϶�. 
-- �� 50���� ����
SELECT employee_id, first_name, job_id, hire_date, salary, department_id 
FROM employees
WHERE salary > (SELECT MIN(salary)
                FROM employees
                WHERE department_id = 50)
    AND department_id <> 50;

-- ����11) EMPLOYEES ���̺��� (50�� �μ��� �ְ� �޿�)�� �޴� ��� ���� ���� �޿��� �޴� ����� ������ 
-- �����ȣ,�̸�,����,�Ի�����,�޿�,�μ���ȣ�� ����϶�. 
-- ��50���� ����

-- scott
-- 37)DECODE �Ǵ� CASE WHEN THEN �Լ��� ����Ͽ� ���� �����Ϳ� ���� JOB���� ���� �������� ��� ����� ����� ǥ���Ͻÿ�.
/*
����        ���
PRESIDENT   A
ANALYST     B
MANAGER     C
SALESMAN    D
CLERK       E
��Ÿ         0
*/
SELECT ename, job,
    DECODE(job,
        'PRESIDENT', 'A',
        'ANALYST', 'B',
        'MANAGER', 'C',
        'SALESMAN', 'D',
        'CLERK', 'E',
        0 ) as Grade    
FROM emp;

SELECT ename, job,
    CASE job
        WHEN 'PRESIDENT' THEN 'A'
        WHEN 'ANALYST' THEN 'B'
        WHEN 'MANAGER' THEN 'C'
        WHEN 'SALESMAN' THEN 'D'
        WHEN 'CLERK' THEN 'E'
        ELSE '0'
    END as Grade
FROM emp;

-- 60) (BLAKE�� ���� �μ�)�� �ִ� ������� �̸��� �Ի����� ���ϴµ� BLAKE�� �����ϰ� ����Ͻÿ�.(BLAKE�� �������� �� ����)

SELECT ename, hiredate
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename = 'BLAKE')
    AND ename != 'BLAKE';

-- 61) ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������ ����ϴµ� 
-- ������ ���� ��������� ����Ͻÿ�.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp)
ORDER BY sal DESC;

-- 62) (10���μ����� �޿��� ���� ���� �޴� ���)�� ������ �޿��� �޴� ����� �̸��� ����Ͻÿ�.
SELECT ename, sal
FROM emp
WHERE sal = (   SELECT MIN(sal)
                FROM emp
                WHERE deptno = 10 );

-- 63) ������� 3���� �Ѵ� �μ��� �μ���� ������� ����Ͻÿ�.
SELECT d.dname, COUNT(e.empno)
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) > 3;

-- 64) �����ȣ�� 7844�� ������� ���� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename, hiredate
FROM emp
WHERE hiredate < (  SELECT hiredate
                    FROM emp
                    WHERE empno = 7844 );

-- 65) ���ӻ��(mgr)�� KING�� ��� ����� �̸��� �޿��� ����Ͻÿ�.
SELECT ename, sal, mgr
FROM emp
WHERE mgr = (SELECT empno
             FROM emp
             WHERE ename = 'KING');

-- 66) (20�� �μ����� ���� �޿�)�� ���� �޴� ����� ������ �޿��� �޴� 
-- ����� �̸��� �μ���,�޿�,�޿������ ����Ͻÿ�.(emp, dept, salgrade(�����̺�))

SELECT e.ename, d.dname, sal, s.grade
FROM emp e, dept d, salgrade s
WHERE sal = (SELECT MAX(sal)
             FROM emp
             WHERE deptno = 20)
    AND e.deptno = d.deptno
    AND sal BETWEEN s.losal AND s.hisal;

--67) �ѱ޿�(sal+comm)�� (��� �޿�)���� ���� �޿��� �޴� ����� 
-- �μ���ȣ, �̸�, �ѱ޿�, Ŀ�̼��� ����Ͻÿ�.(Ŀ�̼��� ��(O),��(X)�� ǥ���ϰ� �÷����� "comm����" ���)
SELECT deptno, ename, sal + NVL(comm, 0), NVL(comm, 0), NVL2(comm, '����', '����')
FROM emp                                            --  (comm != null) ? "����":"����"
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal) FROM emp);

-- 68) CHICAGO �������� �ٹ��ϴ� ����� ��� �޿����� ���� �޿��� �޴� ����� 
-- �̸��� �޿�, �������� ����Ͻÿ�.
-- 1.������ ���� �μ���ȣ
-- 2.��ձ޿�
-- 3.��

SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE sal > (   SELECT AVG(sal)
                FROM emp
                WHERE deptno = (SELECT deptno
                                FROM dept
                                WHERE loc = 'CHICAGO')
            )
    AND e.deptno = d.deptno;

-- 69) ������ SALESMAN�� ������ 2�� �̻��� �μ��� �̸�, �ٹ��ϴ� ����� �̸�, ������ ����Ͻÿ�.(�÷����� �μ���, �����, ������ ���)
SELECT d.dname �μ���, e.ename �����, e.job ����
FROM emp e, dept d
WHERE e.deptno = d.deptno
    AND d.deptno IN(  SELECT deptno
                    FROM emp
                    WHERE job = 'SALESMAN'
                    GROUP BY deptno
                    HAVING COUNT(job) >= 2); 

-- 70) Ŀ�̼��� ���� ����� �� ������ ���� ���� ����� �̸��� �޿������ ����Ͻÿ�.

SELECT e.ename, s.grade
FROM emp e, salgrade s
WHERE sal = (SELECT MAX(sal)
            FROM emp
            WHERE comm IS NULL or comm = 0)
    AND sal BETWEEN s.losal AND s.hisal;

-- 71) (SMITH�� ������(mgr))�� �̸��� �μ���, �ٹ������� ����Ͻÿ�. 
SELECT e.ename, d.dname, d.loc
FROM emp e, dept d
WHERE e.empno = (   SELECT mgr
                    FROM emp
                    WHERE ename = 'SMITH')
    AND e.deptno = d.deptno;












