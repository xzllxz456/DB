/* ********* ����(�� ROLE) ***********
����(��, ROLE) : DB ��ü �� �ý��ۿ� ���� ������ ��Ƶ� ������ �ǹ�
���� ���� : CREATE ROLE �����̸�
���� ���� : DROP ROLE �����̸�
���ҿ� ���� �ο� : GRANT ���� [ON ��ü] TO �����̸�
������ ���� ȸ�� : REVOKE ���� [ON ��ü] FROM �����̸�
����ڿ��� ���� �ο� : GRANT �����̸� TO �����

<���� �������� ����� �߰������� �ܰ�>
CREATE ROLE - ���һ���
GRANT - ������� ���ҿ� ���� �ο�
GRANT - ����ڿ��� ���� �ο�
-->>���� ������ ��� �ݴ�� ����
DROP ROLE - ���� ����(����ڿ��� �ο��� ���ҿ� ���� ���� ���� ���ŵ�)
***************************************/
-- ����� �������� �˻� ����(��) ��ȸ
SELECT * FROM USER_ROLE_PRIVS;
-- (SYSTEM) CONNECT, RESOURCE �ѿ� ���� ���� Ȯ��
SELECT * FROM DBA_SYS_PRIVS;
SELECT * FROM DBA_SYS_PRIVS 
    WHERE GRANTEE IN('CONNECT', 'RESOURCE')
    ORDER BY GRANTEE, PRIVILEGE;
-------------------------------------------
-- (SYSTEM) ��(ROLE) ���� : PROGRAMMER(������) ��� ����(��,ROLE)����
CREATE ROLE PROGRAMMER;

--(SYSTEM)PROGRAMMER�ѿ� ���� �ο� ���̺�, ��(VIEW) ���� ���� ���
GRANT CREATE ANY TABLE, CREATE ANY VIEW TO PROGRAMMER;

--(SYSTEM) MDGUEST �������� PROGRAMMER�� �ο�

CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
GRANT CONNECT, RESOURCE TO MDGUEST;
--(SYSTEM)MDGUEST���� �� �ο�
GRANT PROGRAMMER TO MDGUEST;
--(MDGUEST)���̺� ���� ���� ���
CREATE TABLE madang.AAA(AAAA NUMBER);
CREATE TABLE HR.BBB(BBBB NUMBER);
SELECT * FROM MADANG.AAA;

--(SYSTEM)��(����)ȸ��(���)
REVOKE PROGRAMMER FROM MDGUEST;
--(SYSTEM) ��(ROLE) ����
DROP ROLE PROGRAMMER;





