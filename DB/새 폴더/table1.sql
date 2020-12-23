/*
    ���Ἲ : column�� ����
            column�� �����ϴ� ����
            
    baseball memberNumber -> �ߺ����� �ʴ´�. �ݵ�� ���� == id, �ֹε�Ϲ�ȣ, E-mail
    
    Primary Key : �⺻Ű. NULL�� ������� ����. �ߺ��� ������� �ʴ´�.
    Unique Key : ����Ű. NULL�� ���.     �ߺ��� ������� �ʴ´�
    Foreign Key : �ܷ�Ű. ����:JOIN -> table�� table�� ���� 
                  �ܷ�Ű�� ����� �÷��� ����� ���̺��� PK, UK�� �����Ǿ� �־�� �Ѵ�  
    CHECK : ������ ����. NULL�� ���
    NOT NULL : NULL�� ������� �ʴ´�
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

INSERT INTO tb_test(COL2) -- ����
VALUES('222');

INSERT INTO tb_test(COL1, COL2) -- ����
VALUES('', '111');

-- Primary Key = NOT NULL + Unique
DROP TABLE tb_test
CASCADE CONSTRAINTS;    -- ���Ἲ���� ����

CREATE TABLE tb_test(
    COL_P VARCHAR2(10) CONSTRAINT PK_TEST PRIMARY KEY,
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(30)
);

INSERT INTO tb_test(COL_P, COL1, COL2)
VALUES('AAA', '111', 'aaa');

INSERT INTO tb_test(COL_P, COL1, COL2)
VALUES('BBB', '111', 'aaa');

INSERT INTO tb_test(COL1, COL2)
VALUES('111', 'aaa');

INSERT INTO tb_test(COL_P, COL1, COL2)
VALUES('', '111', 'aaa');

select * from tb_test;

-- UNIQUE : �ش� �÷����� �Ѱ��� ������ �Է�. NULL ��� == E-MAIL
DROP TABLE tb_test;

CREATE TABLE tb_test(
    COL_U VARCHAR2(10) CONSTRAINT UK_TEST UNIQUE,
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(20)
);

INSERT INTO tb_test(COL_U, COL1, COL2)
VALUES('AAA', 'aaa', '111');

INSERT INTO tb_test(COL1, COL2) 
VALUES('aaa', '111');

SELECT * FROM tb_test;

ALTER TABLE tb_test
DROP CONSTRAINT UK_TEST;

-- FOREIGN KEY : �ܷ�Ű
--  DEPARTMENTS
CREATE TABLE TB_PARENT(
    COL_PK VARCHAR2(10) CONSTRAINT PK_PARENT PRIMARY KEY,
    COL1 VARCHAR2(20),
    COL2 VARCHAR2(20)
);

-- EMPLOYEES
CREATE TABLE TB_CHILD(
    KEY1 VARCHAR2(10),
    KEY2 VARCHAR2(20),
    COL_PK VARCHAR2(10),    -- FOREIGN KEY
    CONSTRAINT FK_CHILD FOREIGN KEY(COL_PK) REFERENCES TB_PARENT(COL_PK)
);

INSERT INTO TB_PARENT(COL_PK, COL1, COL2)
VALUES('AAA', 'aaa', '111');

INSERT INTO TB_PARENT(COL_PK, COL1, COL2)
VALUES('BBB', 'bbb', '222');

INSERT INTO TB_PARENT(COL_PK, COL1, COL2)
VALUES('CCC', 'ccc', '333');

SELECT * FROM TB_PARENT;

INSERT INTO tb_child(KEY1, KEY2, COL_PK)
VALUES('111', '222', 'AAA');

INSERT INTO tb_child(KEY1, KEY2, COL_PK)
VALUES('111', '222', 'DDD');

INSERT INTO tb_child(KEY1, KEY2)
VALUES('111', '222');

SELECT * FROM tb_child;

-- CHECK : ������ ���� �Է��� �� ����, NULL�� ���
CREATE TABLE TB_CHECK(
    COL1 VARCHAR2(10),
    KEY1 VARCHAR2(10),
    CONSTRAINT TB_CHK1 CHECK( COL1 IN('���', '��', '�ٳ���')),
    CONSTRAINT TB_CHK2 CHECK( KEY1 > 0 AND KEY1 <= 100 )
);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('���', 12);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('���', 0);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('', 25);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('', '');





