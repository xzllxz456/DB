-- 50) ��� ����� �̸�, �μ���ȣ, �μ��̸��� ǥ���Ͻÿ�.(emp,dept)
SELECT e.ename, e.deptno, d.dname
FROM emp e , dept d
WHERE e.deptno = d.deptno;

SELECT e.ename, e.deptno, d.dname
FROM emp e INNER JOIN dept d
    ON e.deptno = d.deptno;
--51) ������ MANAGER�� ����� ������ �̸�,����,�μ���,�ٹ��� ������
--    ����Ͻÿ�.(emp,dept)
SELECT e.ename, e.job, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT e.ename, e.job, d.dname, d.loc
FROM emp e INNER JOIN dept d
    ON e.deptno = d.deptno;
-- 52) Ŀ�̼��� �ް� �޿��� 1,600�̻��� ����� ����̸�,�μ���,�ٹ����� ����Ͻÿ�
SELECT e.ename, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno AND sal > 1600;

SELECT e.ename, d.dname, d.loc
FROM emp e INNER JOIN dept d
    ON e.deptno = d.deptno
WHERE sal > 1600;

-- 53) �ٹ����� CHICAGO�� ��� ����� �̸�,����,�μ���ȣ �� �μ��̸��� ǥ���Ͻÿ�.
SELECT e.ename, e.job, d.deptno, d.dname
FROM emp e , dept d
WHERE e.deptno = d.deptno AND d.loc LIKE 'CHICAGO';

SELECT e.ename, e.job, d.deptno, d.dname
FROM emp e INNER JOIN dept d
    ON e.deptno = d.deptno
WHERE d.loc LIKE 'CHICAGO';
-- 54) �ٹ������� �ٹ��ϴ� ����� ���� 5�� ������ ���, �ο��� ���� ���ü����� �����Ͻÿ�.-------------
-- (�ٹ� �ο��� 0���� ���� ǥ��)
SELECT d.loc, COUNT(e.empno)
FROM emp e RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno
GROUP BY d.loc
HAVING COUNT(job) <= 5
ORDER BY COUNT(*) asc;

SELECT d.loc, COUNT(e.empno)
FROM emp e , dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.loc
HAVING COUNT(job) <= 5
ORDER BY COUNT(*) asc;

-- 55) ����� �̸� �� ��� ��ȣ�� �������� �̸��� ������ ��ȣ�� �Բ� ǥ���ϰ� 
-- ������ �� ���̺��� employee, emp#, manager, mgr#�� �����Ͻÿ�.
SELECT a.ename as "employee", a.mgr as "emp#",
        b.ename as "manager", a.empno as "mgr#"
FROM emp a, emp b
WHERE a.empno = b.mgr;

SELECT a.ename as "employee", a.mgr as "emp#",
        b.ename as "manager", a.empno as "mgr#"
FROM emp a INNER JOIN emp b
    ON a.empno = b.mgr;
-- 56) �����ں��� ���� �Ի��� ��� ����� �̸� �� �Ի����� �������� �̸� �� �Ի��ϰ� �Բ� ǥ���ϰ� �����ں��� �Ի����� ���� ����� �����϶�.
-- �� ���̺��� ���� employee, emp hired, manager, mgr hired�� ����
SELECT a.ename as "employee", a.hiredate as "emp hired",
        b.ename as "manager", b.hiredate as "mgr hired"
FROM emp a, emp b
WHERE a.empno = b.mgr AND a.hiredate > b.hiredate;

SELECT a.ename as "employee", a.hiredate as "emp hired",
        b.ename as "manager", b.hiredate as "mgr hired"
FROM emp a INNER JOIN emp b
    ON a.empno = b.mgr
WHERE a.empno = b.mgr AND a.hiredate > b.hiredate;

-- 57) ����� �̸� �� �����ȣ�� �������� �̸��� ������ ��ȣ�� �Բ� ǥ���ϰ� 
-- ������ �� ���̺��� employee, emp#, manager, mgr#�� �����ϴµ� 
-- King�� �����Ͽ� �����ڰ� ���� ��� ����� ǥ���ϵ��� �ϰ� 
-- ����� �����ȣ�� �������� ����
SELECT a.ename as "employee", a.empno as "emp#",
        b.ename as "manager", b.empno as "mgr#"
FROM emp a, emp b
WHERE a.empno(+) = b.mgr
ORDER BY a.empno asc;

SELECT a.ename as "employee", a.empno as "emp#",
        b.ename as "manager", b.empno as "mgr#"
FROM emp a RIGHT OUTER JOIN emp b
    ON a.empno = b.mgr
ORDER BY a.empno asc;

-- 58) ������ �μ���ȣ, ����̸� �� ������ ����� ������ �μ����� �ٹ��ϴ� 
-- ��� ����� ǥ���ϵ��� ���Ǹ� �ۼ��ϰ� 
-- �μ���ȣ�� department, ����̸��� employee, ������ �μ����� �ٹ��ϴ� ����� colleague�� ǥ���Ͻÿ�.
-- (�μ���ȣ, ����̸�,���� ������ �������� ����) 
SELECT a.empno as "department", a.ename as "employee", b.deptno, b.ename as "colleague"
FROM emp a, emp b
WHERE a.deptno = b.deptno AND a.empno<>b.empno AND a.ename = 'SMITH'
ORDER BY a.deptno, a.ename, b.ename;

SELECT a.empno as "department", a.ename as "employee", b.deptno, b.ename as "colleague"
FROM emp a INNER JOIN emp b
    ON a.deptno = b.deptno
WHERE a.empno<>b.empno AND a.ename = 'SMITH'
ORDER BY a.deptno, a.ename, b.ename;
    
-- 59)10�� �μ����� �ٹ��ϴ� ������� 
-- �μ���ȣ, �μ��̸�, ����̸�, ����, �޿������ ����Ͻÿ�.
SELECT e.deptno, d.dname, e.ename, s.grade
FROM emp e, dept d, salgrade s
WHERE e.deptno = d.deptno 
    AND e.sal BETWEEN s.losal AND s.hisal
    AND d.deptno = 10;
    
SELECT e.deptno, d.dname, e.ename, s.grade
FROM emp e 
  INNER JOIN dept d ON e.deptno = d.deptno 
    INNER JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE d.deptno = 10;
  
