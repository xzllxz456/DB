--38)��� ����� �޿��� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. �� ���̺��� ����
--   maximum,minimum,sum �� average�� �����ϰ� ����� ������ �ݿø��ϰ� ���ڸ� ������
--   ,�� ����Ͻÿ�.
SELECT to_char(MAX(sal), '9,999') as "maximum" ,
        to_char(MIN(sal),'9,999') as "minimum" , 
        to_char(SUM(sal), '99,999') as "sum" , 
        -- trunc(AVG(sal)) as "average"
        to_char(AVG(sal), '9,999')as "average"
FROM emp;


--39) ������ ������ ��� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
SELECT job, COUNT(*)
FROM emp
GROUP BY job;

--40) emp���̺��� 30���μ��� ������� ���Ͻÿ�.
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING deptno = 30;
SELECT COUNT(*)
FROM emp
WHERE deptno = 30;

--41) emp���̺��� ������ �ְ� ������ ���ϰ� ����,�ְ� ������ ����Ͻÿ�.
SELECT job, MAX(sal)
FROM emp
GROUP BY job;

--42) emp���̺��� 20���μ��� �޿� �հ踦 ���ϰ� �޿� �հ� �ݾ��� ����Ͻÿ�.
SELECT SUM(sal)
FROM emp
WHERE deptno = 20
GROUP BY deptno;

--43) emp���̺��� �μ����� ���޵Ǵ� �ѿ��޿��� �ݾ��� 7,000�̻��� �μ���ȣ, �ѿ����� ����Ͻÿ�.
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) >= 7000;
--44) emp���̺��� �������� ����� ���� ���� ����� ���ϰ� �� ��� ������ ����� 79�� �����ϴ�
--    ����� �����ֽÿ�.
SELECT job, MAX(empno)
FROM emp
WHERE empno LIKE '79%'
GROUP BY job;

SELECT job, MAX(empno)
FROM emp
GROUP BY job
HAVING MAX(empno) LIKE '7%';
-- HAVING 
--45) emp���̺��� ������ �ѿ����� ����ϴµ� ������ 'MANAGER'�� ������� �����ϰ� 
--    �ѿ����� 5,000���� ū ������ �ѿ��޸� ����Ͻÿ�.
SELECT job, SUM(sal)
FROM emp
WHERE job <> 'MANAGER'
GROUP BY job
HAVING SUM(sal) > 5000;

--46)emp���̺��� �������� ������� 4�� �̻��� ������ �ο����� ����Ͻÿ�.
SELECT job, COUNT(*)
FROM emp
GROUP BY job
HAVING COUNT(*) >= 4;
--47)emp���̺��� ������� 5���� �Ѵ� �μ��� �μ���ȣ�� ������� ���Ͻÿ�.
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
HAVING COUNT(*) > 5;
--48)emp���̺��� �μ��� �޿������ ���� �� �Ҽ��� 3�ڸ����� �ݿø��ؼ� 2�ڸ�����
--   ���ϰ� �μ���ȣ, �޿������ ����Ͻÿ�.
SELECT d.dname, e.deptno, ROUND(AVG(e.sal),2)
FROM emp e INNER JOIN dept d
    ON e.deptno = d.deptno
GROUP BY d.dname, e.deptno;

SELECT E.DEPTNO, E.AVGSAL, D.DNAME
FROM (SELECT DEPTNO, ROUND(AVG(sal),2) AS AVGSAL FROM EMP GROUP BY DEPTNO) E
    INNER JOIN DEPT D 
    ON E.DEPTNO = D.DEPTNO;