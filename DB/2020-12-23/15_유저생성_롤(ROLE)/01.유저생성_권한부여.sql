/* ********* ����� ����, ���� *********
-- ����� ���� : CREATE USER
CREATE USER ����ڸ�(������) --"MDGUEST" 
IDENTIFIED BY ��й�ȣ --"mdguest"  
DEFAULT TABLESPACE ���̺����̽� --"USERS"
TEMPORARY TABLESPACE �ӽ��۾����̺����̽� --"TEMP";

-- ����� �뷮 ����(����)
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";

-- ����� ���� : ALTER USER 
ALTER USER ����ڸ�(������) IDENTIFIED BY ��й�ȣ;

-- ���Ѻο�(�� ��� ���� �ο�, �� �ο�)
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;

-- ����� ���� : DROP USER
DROP USER ������ [CASCADE];
--CASCADE : ���������� �����(����)�� ������ ��� ����Ÿ ����
*************************************/
--(�����ڰ��� SYSTEM) �������� ������ ���� SYTTEM���� �۾�
-- ������ : MDGUEST, ��ȣ : mdguest
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- ��(����) �ο� : GRANT
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
GRANT CONNECT, RESOURCE TO MDGUEST;

-- �� ���� ���� �ο�
GRANT CREATE VIEW TO "MDGUEST" ;
------------------
--(SYSTEM) CONNECT, RESOUCE ��(ROLE)�� �ִ� ���� Ȯ��
SELECT *
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
 ORDER BY GRANTEE, PRIVILEGE
;

--=============================
/****** ���� �ο�(GRANT), ���� ���(REVOKE) **********************
GRANT ���� [ON ��ü] TO {�����|ROLE|PUBLIC,.., n} [WITH GRANT OPTION]
--PUBLIC�� ��� ����ڿ��� ������ �ǹ�

GRANT ���� TO �����; --������ ����ڿ��� �ο�
GRANT ���� ON ��ü TO �����; -��ü�� ���� ������ ����ڿ��� �ο�
-->> WITH GRANT OPTION :��ü�� ���� ������ ����ڿ��� �ο� 
-- ������ ���� ����ڰ� �ٸ� ����ڿ��� ���Ѻο��� �Ǹ� ����
GRANT ���� ON ��ü TO ����� WITH GRANT OPTION;
--------------------
-->>>���� ���(REVOKE)
REVOKE ���� [ON ��ü] FROM {�����|ROLE|PUBLIC,.., n} CASCADE
--CASCADE�� ����ڰ� �ٸ� ����ڿ��� �ο��� ���ѱ��� ��ҽ�Ŵ
  (Ȯ�� �� ���� �� �۾�)

REVOKE ���� FROM �����; --������ ����ڿ��� �ο�
REVOKE ���� ON ��ü FROM �����; -��ü�� ���� ������ ����ڿ��� �ο�
*************************************************/
--���Ѻο� : MADANG ������ BOOK ���̺� ���� SELECT ������ MDGUEST���� �ο�
----(SYSTEM) ���Ѻο� - MADANG.BOOK
SELECT * FROM MADANG.BOOK;
GRANT SELECT ON MADANG.BOOK TO MDGUEST;

----(MDGUEST) MADANG.BOOK ���̺� ������ ��ȸ(SELECT) �� �� ����
SELECT * FROM MADANG.BOOK; -- OK
SELECT * FROM MADANG.CUSTOMER; --���Ѿ��� ���ٺҰ� : ORA-00942: table or view does not exist

----(SYSTEM) ���� ȸ��(REVOKE) - MADANG.BOOK
REVOKE SELECT ON MADANG.BOOK FROM MDGUEST;
--============================
--(MADANG ��������) CUSTOMER ���̺� ���Ͽ� MDGUEST ��������
---- SELECT, UPDATE ���� �ο�
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST;

---(MDGUEST ����) CUSTOMER ���̺� SELECT, UPDATE
--������ �ο��޾Ƽ� SELECT, UPDATE �۾� ����
SELECT * FROM MADANG.CUSTOMER; 
UPDATE MADANG.CUSTOMER
   SET PHONE = '010-1111-2222'
 WHERE NAME = '�ڼ���'
;
-- ���� ��� : REVOKE
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST;
--------------------
--(MADANG) WITH GRANT OPTION : �ٸ� �������� ���� �ο��� �� �ֵ��� ���
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION;

--(MDGUEST) �ٸ� �������� ���� �ο�
GRANT SELECT, UPDATE ON MADANG.CUSTOMER TO HR;
SELECT * FROM MADANG.CUSTOMER;

--(HR) MADANG.CUSTOMER SELECT
SELECT * FROM MADANG.CUSTOMER; --OK
SELECT * FROM MADANG.BOOK; --ORA-00942: table or view does not exist

--(MADANG) MDGUEST ����ȸ�� 
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST;

--=======================
--(������ SYSTEM ����) ��������
DROP USER MDGUEST CASCADE;

