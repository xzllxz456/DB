--7)DECODE �Ǵ� CASE WHEN THEN �Լ��� ����Ͽ� ���� �����Ϳ� ���� JOB���� ���� ��������
--��� ����� ����� ǥ���Ͻÿ�.
--����        ���
--PRESIDENT   A
--ANALYST     B
--MANAGER     C
--SALESMAN    D
--CLERK       E
--��Ÿ         0
SELECT job,
    CASE job 
        WHEN 'PRESIDENT' THEN 'A'
        WHEN 'ANALYST' THEN 'B'
        WHEN 'MANAGER' THEN 'C'
        WHEN 'SALESMAN' THEN 'D'
        WHEN 'CLERK' THEN 'E'
        ELSE '0'
    END AS "���"
FROM emp;

SELECT ename, job,
    decode(  job,  'PRESIDENT' , 'A',
         'ANALYST' , 'B',
         'MANAGER' , 'C',
         'SALESMAN' , 'D',
         'CLERK' , 'E',
         '0') as GRADE
FROM emp;

-- 60) BLAKE�� ���� �μ��� �ִ� ������� �̸��� �Ի����� ���ϴµ� 
-- BLAKE�� �����ϰ� ����Ͻÿ�.(BLAKE�� �������� �� ����)
SELECT ename, hiredate
FROM emp
WHERE job IN(SELECT job
FROM emp WHERE ename = 'BLAKE' GROUP BY job) AND ename <> 'BLAKE';
-- 61) ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������ ����ϴµ� 
-- ������ ���� ��������� ����Ͻÿ�.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT trunc(AVG(sal)) FROM emp)
ORDER BY sal DESC;
-- 62) 10���μ����� �޿��� ���� ���� �޴� ����� ������ �޿��� �޴� ����� �̸��� ����Ͻÿ�.
SELECT ename, sal, deptno
FROM emp
WHERE sal IN(SELECT MIN(sal) FROM emp WHERE deptno = 10); 

-- 63) ������� 3���� �Ѵ� �μ��� �μ���� ������� ����Ͻÿ�.

SELECT d.dname, e.cnt
FROM dept d, (SELECT deptno,count(empno) as cnt 
                FROM emp GROUP BY deptno)e
WHERE d.deptno = e.deptno 
    AND e.cnt>=3; -- ���1)
    
SELECT d.dname,COUNT(e.empno) cnt 
FROM emp e, dept d 
WHERE e.deptno = d.deptno 
GROUP BY d.dname 
HAVING COUNT(e.empno)>3; --���2)

-- 64) �����ȣ�� 7844�� ������� ���� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename, hiredate
FROM emp
WHERE hiredate < (SELECT hiredate 
                    FROM emp
  WHERE empno = 7844);

-- 65) ���ӻ�簡 KING�� ��� ����� �̸��� �޿��� ����Ͻÿ�.
SELECT ename, sal
FROM emp
WHERE mgr = (SELECT empno
FROM emp 
WHERE ename = 'KING');
-- 66) 20�� �μ����� ���� �޿��� ���� �޴� ����� ������ �޿��� �޴� 
-- ����� �̸��� �μ���,�޿�, �޿������ ����Ͻÿ�.(emp, dept, salgrade)
SELECT e.ename, e.deptno, d.dname, e.sal, s.grade
FROM emp e INNER JOIN dept d ON e.deptno = d.deptno 
            INNER JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.sal = (SELECT MAX(sal)
FROM emp 
WHERE deptno = 20);

SELECT e.ename, e.deptno, d.dname, e.sal, s.grade
FROM emp e, dept d, salgrade s
WHERE sal = (SELECT MAX(sal) from emp where deptno = 20)
    and e.deptno = d.deptno
        ANd sal BETWEEN s.losal AND s.hisal;
--67) �ѱ޿�sal+comm�� ��� �޿����� ���� �޿��� �޴� ����� �μ���ȣ, �̸�, �ѱ޿�, 
--    Ŀ�̼��� ����Ͻÿ�.(Ŀ�̼��� ��(O),��(X)�� ǥ���ϰ� �÷����� "comm����" ���)
SELECT deptno, ename, sal+NVL(comm,0),NVL(comm,0),NVL2(comm , '��', '��')
FROM emp
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal)
FROM emp);

SELECT deptno,ename,sal+nvl(comm,0) �ѱ޿� ,
    CASE 
    WHEN comm IS NOT NULL then 'o' 
    ELSE 'x'
    END AS "comm����" FROM emp 
    WHERE sal+NVL(comm,0) >(SELECT avg(sal) FROM emp);

-- 68) CHICAGO �������� �ٹ��ϴ� ����� ��� �޿����� ���� �޿��� �޴� ����� �̸��� �޿�,
--    �������� ����Ͻÿ�.
SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
    AND e.sal > (SELECT AVG(e.sal)
                    FROM emp e, dept d WHERE e.deptno = d.deptno 
                        AND d.loc = 'CHICAGO');

SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE sal >
(SELECT AVG(sal)
FROM emp 
where deptno = (SELECT deptno
FROM dept 
WHERE loc = 'CHICAGO')
) and e.deptno = d.deptno;


-- 69) ������ SALESMAN�� ������ 2�� �̻��� �μ��� �̸�, �ٹ��ϴ� ����� �̸�, ������ ���
--    �Ͻÿ�.(�÷����� �μ���, �����, ������ ���)
SELECT d.dname as "�μ���", e.ename as "�����", e.job as "����"
FROM emp e, dept d
WHERE e.deptno = d.deptno
    AND e.deptno IN (SELECT deptno FROM emp 
                    GROUP BY deptno
                    HAVING COUNT(job) >= 2)
                    AND job = 'SALESMAN' ;
                    

SELECT d.dname as "�μ���", e.ename as "�����", e.job as "����"
FROM emp e, dept d      
WHERE e.deptno = d.deptno
    AND e.job = 'SALESMAN'
   AND d.dname = (SELECT d.dname FROM emp e, dept d
    where e.deptno = d.deptno
        and e.job = 'SALESMAN'
        GROUP BY d.dname
        HAVING COUNT(e.empno) > 2);
-- 70) Ŀ�̼��� ���� ����� �� ������ ���� ���� ����� �̸��� �޿������ ����Ͻÿ�.
SELECT e.ename,e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal and s.hisal
    AND e.sal = (SELECT MAX(sal)
    FROM emp
    where comm IS NULL);

-- 71) SMITH�� �������� �̸��� �μ���, �ٹ������� ����Ͻÿ�. 
SELECT e.ename, d.dname, d.loc
FROM emp e ,dept d
WHERE e.deptno = d.deptno
    AND e.empno  = (SELECT mgr
    FROM emp where ename = 'SMITH');
    