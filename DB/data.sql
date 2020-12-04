SELECT
    *
FROM employees;
-- ���� �ּ���
/*
����
�ּ���
*/

-- table : colum(�׸� (����̸�, ��ȣ ...)), row (�ϳ��� ������)
-- tablespace memory���� -> ����

-- table ����
/*
CREATE TABLE ���̺��(
    �÷���1 �ڷ���, �ڷ����� �ѱ�x
    �÷���2 �ڷ���,
    �÷���3 �ڷ���
);

DROP TABLE ���̺��;
*/

-- �ڷ���
/*
    Java        Oracle
    int         Integer, NUMBER
    double      Number(������ �ڸ���, �Ҽ��� �ڸ���)
    string      VARCHART2, CHAR, LONG
    Date        DATE
    
*/

-- ���ڿ�
-- CHAR  ���ڿ��� �ٷ�
CREATE TABLE TB_CHAR(
    COL1 CHAR(10 BYTE),
    COL2 CHAR(10 CHAR),
    COL3 CHAR(10)
);

/*
    INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3) 
    VALUES(��, ��, ��);
    
    INTEGER -> 123
    STRING -> 'HELLO' -> �������� ���� '' �� ����ִ´�.
    
    ���縵1���ǹ��� -> 1BYTE
    �ѱ� 1���� -> 3BYTE
*/
INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('ABC', 'ABC', 'ABC');
SELECT    * FROM tb_char;

INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('��', '��', '��');
INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('����', '����', '����');
INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('������', '������', '������');
SELECT    *FROM tb_char;

SELECT COL1, COL2, COL3, LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
FROM Tb_CHAR;

/*
    CHAR : 10 BYTE 00000 00000
    ABC ->         ABC00 00000
  ��(3byte)+9 = 12 
  ����(6byte)+8 = 14
  rkskek(9byte)+7 = 16
*/

--VARCHAR2
CREATE TABLE TB_VARCHAR(
    COL1 VARCHAR2(10 BYTE),
    COL2 VARCHAR2(10 CHAR),
    COL3 VARCHAR2(10)
);
INSERT INTO tb_valchar(COL1, COL2, COL3)
VALUES('ABC', 'ABC', 'ABC');
INSERT INTO tb_valchar(COL1, COL2, COL3)
VALUES('������', '������', '������');
SELECT*FROM tb_valchar;
SELECT COL1, COL2, COL3, LENGTHB(COL1), LENGTHB(COL2), LENGTHB(COL3)
FROM tb_valchar;

/*
    LONG
    �ִ� 2GB���� ����
    TABLE �� 1���� ��밡��
*/
CREATE TABLE TB_LONG(
    COL1 LONG
  --  COL2 LONG�� LONG�Ѱ�, �ϳ��� ���̺� ��� ����  
);

INSERT INTO tb_long(COL1)
VALUES('DSAFDHUSAIFHSJAFHSJKAFHDJKSAHFKJHSDAKJF');
INSERT INTO tb_long(COL1)
VALUES('DSAFDHUSAIFHSJAFHSJKAFHDJKSAHFKJHSDAKJF');

SELECT * FROM tb_long;

SELECT COL1, LENGTHB(COL1)  -- LONG�� LENGTHB���Ұ�
FROM tb_long;

-- å���̺�
CREATE TABLE BOOK(
    TITLE VARCHAR2(20),
    BOOKCONTENT LONG,
    NO NUMBER,
    PRICE NUMBER
  --  COL2 LONG�� LONG�Ѱ�, �ϳ��� ���̺� ��� ����  
);

-- ����(����, �Ҽ�)
-- INTEGER ����
CREATE TABLE TB_INTEGER(
    COL1 INTEGER,
    COL2 INTEGER
);

INSERT INTO TB_INTEGER(COL1, COL2)
VALUES(123, 456);
INSERT INTO TB_INTEGER(COL1, COL2)
VALUES(123, 456.1);

SELECT * FROM TB_INTEGER;

INSERT INTO TB_INTEGER(COL1, COL2)
VALUES('123', '456'); -- ���ڿ��� �ٰ����� �������
SELECT * FROM TB_INTEGER;

-- NUMBER ����, �Ҽ� ����
CREATE TABLE TB_NUMBER(
    COL1 NUMBER,
    COL2 NUMBER(5),-- 5�ڸ�
    COL3 NUMBER(5, 2),--5�ڸ� �Ҽ�2�ڸ�
    COL4 NUMBER(*,2)-- �ڸ�����, �Ҽ� 2�ڸ�
);

INSERT INTO TB_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234.5678, 12345.12, 123.456, 1234.5678);

SELECT * FROM TB_NUMBER;

-- ��¥ DATE
-- ����, ��, ��, ��, ��, ��
CREATE TABLE TB_DATE(
    COL1 DATE,
    COL2 DATE
);

INSERT INTO TB_DATE(COL1, COL2)
VALUES(SYSDATE, SYSDATE - 1);

SELECT * FROM TB_DATE;
-- TO_DATE(��¥ ���ڿ�, ���� ���ڿ�) �������� ������ �������� �ٲ۴�
INSERT INTO TB_DATE(COL1, COL2)
VALUES(SYSDATE, TO_DATE('2020-12-25 12:30:25', 'YYYY-MM-DD HH:MI:SS'));

INSERT INTO TB_DATE(COL1, COL2)
VALUES(SYSDATE, '2020-12-31');

INSERT INTO TB_DATE(COL1, COL2)
VALUES(SYSDATE, '20/12/30');
SELECT * FROM TB_DATE;

INSERT INTO TB_DATE(COL1, COL2)
VALUES(SYSDATE, TO_DATE('20201225123025', 'YYYYMMDDHHMISS'));

DROP TABLE TB_CHAR;
DROP TABLE TB_VALCHAR;
DROP TABLE TB_INTEGER;
DROP TABLE TB_LONG;
DROP TABLE TB_DATE;
DROP TABLE TB_NUMBER;
