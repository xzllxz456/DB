/*
    무결성 : column에 적용
            column에 지정하는 성질
            
    baseball memberNumber -> 중복되지 않는다. 반드시 기입 == id, 주민등록번호, E-mail
    
    Primary Key : 기본키. NULL을 허용하지 않음. 중복을 허용하지 않는다.
    Unique Key : 고유키. NULL을 허용.     중복을 허용하지 않는다
    Foreign Key : 외래키. 목적:JOIN -> table과 table을 연결 
                  외래키로 연결된 컬럼은 연결된 테이블에서 PK, UK로 설정되어 있어야 한다  
    CHECK : 범위를 설정. NULL을 허용
    NOT NULL : NULL을 허용하지 않는다
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

INSERT INTO tb_test(COL2) -- 에러
VALUES('222');

INSERT INTO tb_test(COL1, COL2) -- 에러
VALUES('', '111');

-- Primary Key = NOT NULL + Unique
DROP TABLE tb_test
CASCADE CONSTRAINTS;    -- 무결성까지 삭제

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

-- UNIQUE : 해당 컬럼에서 한개의 값만을 입력. NULL 허용 == E-MAIL
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

-- FOREIGN KEY : 외래키
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

-- CHECK : 지정된 값외 입력할 수 없고, NULL을 허용
CREATE TABLE TB_CHECK(
    COL1 VARCHAR2(10),
    KEY1 VARCHAR2(10),
    CONSTRAINT TB_CHK1 CHECK( COL1 IN('사과', '배', '바나나')),
    CONSTRAINT TB_CHK2 CHECK( KEY1 > 0 AND KEY1 <= 100 )
);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('사과', 12);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('사과', 0);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('', 25);

INSERT INTO TB_CHECK(COL1, KEY1)
VALUES('', '');





