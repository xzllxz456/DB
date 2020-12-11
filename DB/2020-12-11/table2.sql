/*
    ����ڳ� �������α׷��� �����ͺ��̽��� ����Ȯ�ϰ� �����ϴ°��� ��� ���� �ʴ¼���
    ���Ἲ : column�� ����
            column�� �����ϴ� ����
    baseball memberNumber -> �ߺ����� �ʴ´�. �ݵ�� ���� id, �ֹε�Ϲ�ȣ, e-mail
    
    primaty key : �⺻Ű, null�� ������� ����, �ߺ� ��� ���� ����
    Unique Key : ����Ű, null�� ���, �ߺ��� ��� ���� �ʴ´�.
    Foreign Key : �ܷ�Ű. ����(JOIN) -> table�� table�� ����, 
                  �ܷ�Ű�� ����� �÷��� ����� ���̺��� PK(primaty key), UK(Unique Key) �� 
                  ���� �Ǿ� �־�� �Ѵ�
    CHECK : ������ ����. NULL�� ���
    NOT NULL : NULL�� ������� �ʴ´�.
*/
-- NOT NULL
CREATE TABLE TB_TEST(
    COL1 VARCHAR2(10) NOT NULL,
    COL2 VARCHAR2(20)
);

INSERT INTO tb_test(COL1, COL2)
VALUES('AAA', '111');

SELECT * FROM tb_test;
INSERT INTO tb_test(COL1)
VALUES('BBB');
INSERT INTO tb_test(COL2)-- ���� COL1 �� NULL
VALUES('222');
INSERT INTO tb_test(COL1, COL2)-- ���� COL1 �� NULL
VALUES('', '111');

-- Primary Key = NOT NULL + Unique
DROP TABLE TB_TEST
CASCADE CONSTRAINTS;

CREATE TABLE tb_test(
    COL_P VARCHAR2(10) CONSTRAINT PK_TEST PRIMARY KEY,
    --COL_P VARCHAR2(10)PRIMARY KEY,
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(30)
);

INSERT INTO tb_test(COL_P, COL1, COL2)
VALUES('AAA', '111', 'aaa');

INSERT INTO tb_test(COL_P, COL1, COL2)
VALUES('BBB', '111', 'aaa');

SELECT * FROM tb_test;
INSERT INTO tb_test( COL1, COL2)
VALUES('111', 'aaa');
INSERT INTO tb_test(COL_P, COL1, COL2)
VALUES('NULL', '111', 'aaa');

-- UNIQUE : �ش� �÷����� �ߺ��� ���� ��� �Ұ� - �Ѱ��� ������ �Է�, NULL ��� == E-MAIL
DROP TABLE tb_test;

CREATE TABLE TB_TEST(
   COL_U VARCHAR2(10) CONSTRAINT UK_TEST UNIQUE,
 --COL_U VARCHAR(10)  UNIQUE,
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(30)
);

INSERT INTO tb_test(COL_U, COL1, COL2)
VALUES('AAA', 'aaa', '111');
INSERT INTO tb_test(COL1, COL2)
VALUES( 'aaa', '111');

ALTER TABLE tb_test
drop constraint UK_TEST;

-- POREIGN KEY : �ܷ�Ű
-- DEPARTMENTS
CREATE TABLE TB_PARENT(
    COL_PK VARCHAR2(10) CONSTRAINT PK_PARENT PRIMARY KEY,
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(20)
);

-- EMPLOYERS
CREATE TABLE TB_CHILD(
    KEY1 VARCHAR2(10),
    KEY2 VARCHAR2(20),
    COL_PK VARCHAR2(10),  -- .�̰� �� Ŀ���Ѵ� -- �ܺθ� �����ϱ� ���� Ű
    CONSTRAINT FK_CHILD FOREIGN KEY(COL_PK) REFERENCES TB_PARENT(COL_PK)
);

INSERT INTO tb_parent(COL_PK, COL1, COL2)
VALUES('AAA','aaa','111');

INSERT INTO tb_parent(COL_PK, COL1, COL2)
VALUES('BBB','bbb','222');

INSERT INTO tb_parent(COL_PK, COL1, COL2)
VALUES('CCC','ccc','333');

SELECT * FROM tb_parent;

INSERT INTO tb_child(KEY1, KEY2, COL_PK)
VALUES('111','222','AAA');
INSERT INTO tb_child(KEY1, KEY2, COL_PK)
VALUES('111','222','DDD');

INSERT INTO tb_child(KEY1, KEY2)
VALUES('111','222');
SELECT * FROM tb_child;

-- CHECK : ������ ���� �Է��� �� ����, NULL�� ���
CREATE TABLE TB_CHECK(
    COL1 VARCHAR2(10),
    KEY1 VARCHAR2(10),
    CONSTRAINT TB_CHK1 CHECK(COL1 IN ('���','��','�ٳ���')),
    CONSTRAINT TB_CHK2 CHECK(KEY1 > 0 AND KEY1 <= 100)
);
INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('���', 12);
INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('��', 0);
INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('', 25);
INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('', '');


-- TABLE�� �ۼ��϶�.
-- TEAM : �� ���̵�, ����, �� ��, ���� ��¥, ��ȭ��ȣ, Ȩ������
-- PLAYER : ������ȣ, ���� ��, �����, ������, Ű, �� ���̵� �ܷ�Ű�� �����Ѵ�.
CREATE TABLE TEAM(
    TEAM_ID VARCHAR2(15) CONSTRAINT PK_TEAM PRIMARY KEY, 
    TEAM_LOC VARCHAR2(10), 
    TEAM_NAME VARCHAR2(30) CONSTRAINT UK_NAME UNIQUE, 
    STARTDATE DATE, 
    PHONE_NUM VARCHAR2(13), 
    TEAM_PAGE VARCHAR2(20)
);
CREATE TABLE PALYER(
    PALYER_ID NUMBER CONSTRAINT PK_PALYER PRIMARY KEY,
    PALYER_NAME VARCHAR2(10),
    PALYER_DATE DATE,
    PALYER_POS VARCHAR2(10),
    PALYER_HEIGET NUMBER,
    TEAM_ID VARCHAR2(15), CONSTRAINT PALYER FOREIGN KEY(TEAM_ID) REFERENCES TEAM(TEAM_ID)
);

-- TEAM �ΰ��� ����϶�.
INSERT INTO TEAM(TEAM_ID, TEAM_LOC, TEAM_NAME, STARTDATE, PHONE_NUM, TEAM_PAGE)
VALUES ('10', '��õ', 'Ÿ�̰���', '2020-11-11', '032-111-1111', 'ABSCOM');
INSERT INTO TEAM(TEAM_ID, TEAM_LOC, TEAM_NAME, STARTDATE, PHONE_NUM, TEAM_PAGE)
VALUES ('11', '�λ�', '�̱���', '2020-11-12', '032-111-2222', 'CDFCOM');
-- �ΰ��� TEAM�� ������ ���� 3�� ����϶�.
INSERT INTO PALYER(PALYER_ID,PALYER_NAME,PALYER_DATE,PALYER_POS,PALYER_HEIGET,TEAM_ID)
VALUES('01', '������', '2020-11-15', 'Ÿ��', 170, 10);
INSERT INTO PALYER(PALYER_ID,PALYER_NAME,PALYER_DATE,PALYER_POS,PALYER_HEIGET,TEAM_ID)
VALUES('02', '����3', '2020-11-15', 'Ÿ��', 172, 10);
INSERT INTO PALYER(PALYER_ID,PALYER_NAME,PALYER_DATE,PALYER_POS,PALYER_HEIGET,TEAM_ID)
VALUES('03', '����2', '2020-11-15', '����', 173, 10);


INSERT INTO PALYER(PALYER_ID,PALYER_NAME,PALYER_DATE,PALYER_POS,PALYER_HEIGET,TEAM_ID)
VALUES('01', '������', '2020-11-15', 'Ÿ��', 170, 11);

-- TABLE�� �ۼ��϶�.
-- PRODUCT(��ǰ) : ��ǰ��ȣ, ��ǰ��, ��ǰ����, ��ǰ����
-- CONSUMER(�Һ���) : �Һ��� ID, �̸�, ����
-- CART(��ٱ���) : ��ٱ��� ��ȣ, �Һ��� ID, ��ǰ��ȣ, ���� �ܷ�Ű�� �����Ѵ�.

DROP TABLE CART;
DROP TABLE CONSUMER;
DROP TABLE PRODUCT;

CREATE TABLE CART(
    ��ٱ��Ϲ�ȣ NUMBER CONSTRAINT PK_CART PRIMARY KEY,
    PERID VARCHAR2(20),
    PRU_NUM VARCHAR2(20), 
    ���� NUMBER,
    CONSTRAINT PRU_NUM FOREIGN KEY(PRU_NUM) REFERENCES PRODUCT(PRU_NUM),
    CONSTRAINT PERID FOREIGN KEY(PERID) REFERENCES CONSUMER(PERID)
);
CREATE TABLE CONSUMER(
    PERID VARCHAR2(20) CONSTRAINT PK_CONSUMER PRIMARY KEY, 
    �̸� VARCHAR2(20) NOT NULL,
    ���� NUMBER
);

CREATE TABLE PRODUCT(
PRU_NUM VARCHAR2(20) CONSTRAINT PK_PRODUCT PRIMARY KEY,
��ǰ�� VARCHAR2(20),
��ǰ���� NUMBER,
��ǰ���� VARCHAR2(50)
);

-- ��ǰ�� 3���� ��� �϶�.

-- �θ��� �Һ��ڸ� ����϶�.
INSERT INTO PRODUCT(PRU_NUM, "��ǰ��", "��ǰ����", "��ǰ����")
VALUES('101', '�����', 1500, '��������� ���찡 �����ϴ�');

INSERT INTO PRODUCT(PRU_NUM, ��ǰ��, ��ǰ����, ��ǰ����)
VALUES(102, '��������Ĩ', 2300, '���ڷ� ����ϴ�');
-- �Һ����� ��ٱ��Ͽ� ��ǰ �߰��϶�.
INSERT INTO consumer(PERID, �̸�, ����)
VALUES('hgd', 'ȫ�浿', 24);

INSERT INTO consumer(PERID, �̸�, ����)
VALUES('ijm', '������', 22);

-- cart
INSERT INTO cart(��ٱ��Ϲ�ȣ, PERID, PRU_NUM, ����)
VALUES(1, 'hgd', 102, 2);

SELECT * FROM cart;