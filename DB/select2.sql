select * from emp;

-- ���� ��Ű���� ��� ���̺�
select * from tab; 

-- ���̺��� �÷����� ����Ѵ�
DESC emp; 

SELECT empno, ename, sal FROM emp;

-- dual : �������̺�
SELECT SYSDATE FROM DUAL;
SELECT 4 * 7 FROM DUAL;
SELECT '4' * 7 FROM DUAL;
SELECT '4' * '7' FROM DUAL;

SELECT 'HELLO' || ' ' || 'ORACLE' FROM DUAL;

SELECT ROUND(10.5) FROM DUAL;

SELECT ename, sal, sal * 12 FROM emp;

-- alias (�÷�����)
SELECT ename AS �̸�, sal, sal * 12
FROM emp;
SELECT ename AS "�� ��", sal as "����", sal * 12 ���� -- as ���̴°� ����(�������)
FROM emp;

-- DISTINCT : �ߺ��� ���� --> group by
SELECT deptno
FROM emp;
SELECT DISTINCT deptno
FROM emp;

SELECT job
from emp;
SELECT DISTINCT job
from emp;

-- 1) emp ���̺��� �����ȣ, ����̸�, ������ ����Ͻÿ�.
SELECT empno,ename,sal 
FROM emp;
-- 2) emp ���̺��� ����̸��� ������ ����ϴµ� �÷����� �� ��, �� ������ �ٲ㼭 ����Ͻÿ�.
SELECT ename as "�� ��", sal as "�� ��"
from emp;
-- 3) emp ���̺��� �����ȣ, ����̸�, ����, ������ ���ϰ� ���� �÷����� �����ȣ, ����̸�, ����, �������� ����Ͻÿ�
SELECT empno as "�����ȣ", ename as "����̸�" ,sal as "�� ��",sal * 12 as "����"
from emp;
-- 4) emp ���̺��� ����(job)�� �ߺ����� �ʰ� ǥ���Ͻÿ�.
SELECT DISTINCT job
from emp;
-- 5) emp ���̺��� ������ ������ ����(SMITH, CHECK)�ؼ� ǥ���ϰ� �÷����� Employee and Job���� ǥ���Ͻÿ�
SELECT (ename || 'SMITH'||'   ,   '|| job|| 'CHECK') "Employee and Job"
from emp;