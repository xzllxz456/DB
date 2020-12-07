--6) emp ���̺��� �����ȣ�� 7698 �� ����� �̸�, ����, �޿��� ����Ͻÿ�
SELECT ename,job,sal
FROM emp
WHERE empno = 7698;

-- 7) emp ���̺��� ����̸��� SMITH�� ����� �̸��� ����, �μ���ȣ�� ���Ͻÿ�.
SELECT ename, sal, deptno
FROM emp
WHERE ename = 'SMITH';

-- 8) ������ 2500�̻� 3500�̸��� ����� �̸�, �Ի���, ������ ���Ͻÿ�.
SELECT ename,hiredate ,sal
FROM emp
WHERE sal >= 2500 AND sal < 3500;

-- 9) �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸�, ����, �޿��� ����Ͻÿ�.
SELECT ename,job ,sal
FROM emp
--WHERE sal <= 2500 or sal > 3500;
WHERE SAL NOT BETWEEN 2000 AND 3000;

-- 10) 81��05��01�ϰ� 81��12��03�� ���̿� �Ի��� ����� �̸�, �޿�, �Ի����� ����Ͻÿ�.
SELECT ename, sal, hiredate
FROM emp
--WHERE hiredate > '81/05/01' AND hiredate < '81/12/03';
WHERE HIREDATE BETWEEN '81/05/01' AND '81/12/03';
-- 11) emp���̺��� �����ȣ�� 7566,7782,7934�� ����� ������ ������� �����ȣ,�̸�,
--    ������ ����Ͻÿ�.
SELECT empno, ename, sal
FROM emp
WHERE empno NOT IN(7566,7782,7934);

-- 12) �μ���ȣ 30(deptno)���� �ٹ��ϸ� �� 2,000�޷� ���ϸ� �޴� 81��05��01�� ������ �Ի��� ����� �̸�, �޿�, �μ���ȣ, �Ի����� ����Ͻÿ�.
SELECT ename, sal, deptno, hiredate
FROM emp
WHERE deptno = 30
    AND sal <= 2000 
    AND hiredate < '81/05/01';

-- 13) emp���̺��� �޿��� 2,000�� 5,000 ���̰� �μ���ȣ�� 10 �Ǵ� 30�� ����� �̸��� �޿�,�μ���ȣ�� �����Ͻÿ�.
SELECT ename, sal, deptno
FROM emp
WHERE (SAL BETWEEN 2000 AND 5000) AND deptno IN(30,10);

-- 14) ������ SALESMAN �Ǵ� MANAGER�̸鼭 �޿��� 1,600, 2,975 �Ǵ� 2,850�� (�ƴ�) ��� ����� �̸�, ���� �� �޿��� ǥ���Ͻÿ�.
SELECT ename, job, sal
FROM emp
WHERE sal NOT IN(1600, 2975,2850) AND job IN('SALESMAN', 'MANAGER');

-- 15) emp���̺��� ����̸� �� S�� ���Ե��� ���� ����� �� �μ���ȣ�� 20�� ������� �̸��� �μ���ȣ�� ����Ͻÿ�.
SELECT ename, deptno
FROM emp
WHERE ename NOT LIKE'%S%' and deptno IN(20);

-- 16) emp���̺��� �̸��� A�� E�� �ִ� ��� ����� �̸��� ǥ���Ͻÿ�.
SELECT ename
FROM emp
WHERE ename LIKE '%A%' AND ename LIKE '%E%';

-- 17) emp���̺��� �����ڰ� ���� ��� ����� �̸��� ������ ǥ���Ͻÿ�.
SELECT ename, deptno
FROM emp
WHERE mgr IS NULL;

-- 18) emp���̺��� Ŀ�̼� �׸��� �Էµ� ������� �̸��� �޿�, Ŀ�̼��� ���Ͻÿ�.
SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL 
        AND COMM <> 0;
  
-- 19) emp ���̺��� �����ȣ, ����̸�, �Ի����� ����ϴµ� 
-- �Ի����� ���� ��������� �����Ͻÿ�.
SELECT empno, ename, hiredate
FROM emp
ORDER BY hiredate DESC;

-- 20) emp ���̺��� ����̸�, �޿�, ������ ���ϰ� ������ ���� ������ �����Ͻÿ�.
SELECT ename, sal, sal*12
FROM emp
ORDER BY sal*12 DESC;

--21)10�� �μ��� 20���μ����� �ٹ��ϰ� �ִ� ����� �̸��� �μ���ȣ�� ����ϴµ� 
-- �̸��� �����ڼ����� ǥ���Ͻÿ�.
SELECT ename, deptno
FROM emp
WHERE deptno IN(10,20)
ORDER BY ename ASC;

--22) Ŀ�̼��� �޴� ��� ����� �̸�,�޿� �� 
-- Ŀ�̼��� Ŀ�̼��� �������� ������������ �����Ͽ� ǥ���Ͻʽÿ�.
SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL AND comm <>0
ORDER BY comm ASC;
