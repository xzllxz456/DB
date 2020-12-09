--23) emp���̺��� ����(job)�� ù���ڴ� �빮�� �������� �ҹ��ڷ� ����Ͻÿ�.
SELECT INITCAP(job)
FROM emp;

--24) emp���̺��� ����̸� �� A�� ���Ե� ����̸��� ���ϰ� �� �̸� �� �տ��� 3�ڸ� �����Ͽ� ���
SELECT SUBSTR(ename,1,3)
FROM emp
WHERE ename LIKE '%A%';

--25) �̸��� ����° ���ڰ� A�� ��� ����� �̸��� ǥ���Ͻÿ�
SELECT ename
FROM emp
WHERE SUBSTR(ename,3,1) = 'A';
--26) �̸��� J,A �Ǵ� M���� �����ϴ� ��� ����� �̸�(ù ���ڴ� �빮�ڷ�, ������ ���ڴ� �ҹ��ڷ�
--    ǥ��) �� �̸��� ���̸� ǥ���Ͻÿ�.(�� ���̺��� name�� length�� ǥ��)
SELECT INITCAP(ename) name, LENGTH(ename) LENGTH
FROM emp
WHERE ename LIKE 'J%'OR ename LIKE 'A%'OR ename LIKE 'M%';

--27) �̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �ҹ��ڷ� �̸��� ����Ͻÿ�
SELECT LOWER(ename)
FROM emp
WHERE length(ename) >= 6;

--28) �̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �տ��� 3�ڸ� ���Ͽ� �ҹ��ڷ� ����Ͻÿ�.
SELECT SUBSTR(LOWER(ename), 1, 3)
FROM emp
WHERE length(ename) >= 6;

--29) ��� ����� �̸��� �޿��� ǥ���Ͻÿ�. �޿��� 15�� ���̷� ���ʿ� $��ȣ�� ä���� ��������
 --   ǥ���ϰ� �����̺��� SALARY�� �����Ͻÿ�.
SELECT ename, LPAD(sal, 15,'$') SALARY
FROM emp;

--30) ���ú��� �̹����� �������������� ���� �� ���� ���Ͻÿ�.
SELECT LAST_DAY(SYSDATE)-SYSDATE
from dual;
--31) emp���̺��� �� ����� ���� �����ȣ, �̸�, �޿� �� 15% �λ�� �޿��� ����(�ݿø�)�� ǥ���Ͻÿ�.
--    �λ�� �޿����� ���̺��� New Salary�� �����Ͻÿ�.
SELECT empno, ename, sal, ROUND(sal*1.15, 0) as "New Salary"
FROM emp;

--32) emp���̺��� ������ 4�� ���(mod(sal,4)=0)�� ����� �̸��� ������ ����Ͻÿ�.(���ڸ� ���� ��ǥ ǥ��)
SELECT ename, TO_CHAR( sal, '$999,999,999')
FROM emp
WHERE MOD(sal,4)=0;
--33) �� ����� �̸��� ǥ���ϰ� �ٹ� �� ��(�Ի��Ϸκ��� ��������� �޼�)�� ����Ͽ�
--�� ���̺��� MONTHS_WORKED�� �����Ͻÿ�. ����� ������ �ݿø��Ͽ� ǥ���ϰ� �ٹ��� ����
--�������� ������������ �����Ͻÿ�.
SELECT ename, round(MONTHS_BETWEEN(SYSDATE , hiredate),0) as MONTHS_WORKED
FROM emp
ORDER BY MONTHS_WORKED asc;
-- SYSDATE - HIREDATE                 �ٹ��ϼ�
-- (SYSDATE - HIREDATE) / 7           �ٹ��ּ�
-- MONTHS_BETWEEN(SYSDATE , hiredate) �ٹ� �޼�

--34)emp���̺��� �̸�, ����, �ٹ������� ����Ͻÿ�.
SELECT ename, job, trunc(MONTHS_BETWEEN(SYSDATE , hiredate)/ 12) AS "�ٹ�����"
FROM emp;
--35)emp���̺��� ����̸�, ����, ���ް� Ŀ�̼��� ���� ���� �÷��� �Ǳ޿���� �ؼ� ���.
--��, NULL���� ��Ÿ���� �ʰ� �ۼ��Ͻÿ�.
 SELECT ename, sal,NVL(comm,0), sal +  NVL(comm,0) as "�Ǳ޿�"
    FROM emp;
--36)���ް� Ŀ�̼��� ��ģ �ݾ��� 2,000�̻��� �޿��� �޴� ����� �̸�,����,����,Ŀ�̼�,��볯¥
--�� ����Ͻÿ�. ��, ��볯¥�� 1980-12-17 ���·� ����Ͻÿ�.
SELECT ename, job, sal, comm ,nvl(comm, 0), sal +  nvl(comm, 0) as "�Ǳ޿�", TO_CHAR(hiredate, 'YYYY-MM-DD')
    FROM emp
    where sal +  nvl(comm, 0) >= 2000;
