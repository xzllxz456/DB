SELECT
    *
FROM employees;
-- 한줄 주석문
/*
범위
주석문
*/

-- table : colum(항목 (사원이름, 번호 ...)), row (하나의 데이터)
-- tablespace memory공간 -> 파일

-- table 생성
/*
CREATE TABLE 테이블명(
    컬럼명1 자료형, 자료형은 한글x
    컬럼명2 자료형,
    컬럼명3 자료형
);

DROP TABLE 테이블명;
*/

-- 자료형
/*
    Java        Oracle
    int         Integer, NUMBER
    double      Number(정수의 자리수, 소수의 자리수)
    string      VARCHART2, CHAR, LONG
    Date        DATE
    
*/

-- 문자열
-- CHAR  문자열을 다룸
CREATE TABLE TB_CHAR(
    COL1 CHAR(10 BYTE),
    COL2 CHAR(10 CHAR),
    COL3 CHAR(10)
);

/*
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3) 
    VALUES(값, 값, 값);
    
    INTEGER -> 123
    STRING -> 'HELLO' -> 문자형은 작은 '' 로 집어넣는다.
    
    스펠링1개의문자 -> 1BYTE
    한글 1문자 -> 3BYTE
*/
INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('ABC', 'ABC', 'ABC');
SELECT    * FROM tb_char;

INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('가', '가', '가');
INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('가나', '가나', '가나');
INSERT INTO TB_CHAR(COL1, COL2, COL3)
VALUES('가나다', '가나다', '가나다');
SELECT    *FROM tb_char;

SELECT COL1, COL2, COL3, LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
FROM Tb_CHAR;

/*
    CHAR : 10 BYTE 00000 00000
    ABC ->         ABC00 00000
  가(3byte)+9 = 12 
  가나(6byte)+8 = 14
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
VALUES('가나다', '가나다', '가나다');
SELECT*FROM tb_valchar;
SELECT COL1, COL2, COL3, LENGTHB(COL1), LENGTHB(COL2), LENGTHB(COL3)
FROM tb_valchar;

/*
    LONG
    최대 2GB까지 저장
    TABLE 당 1개만 사용가능
*/
CREATE TABLE TB_LONG(
    COL1 LONG
  --  COL2 LONG은 LONG한개, 하나의 테이블만 사용 가능  
);

INSERT INTO tb_long(COL1)
VALUES('DSAFDHUSAIFHSJAFHSJKAFHDJKSAHFKJHSDAKJF');
INSERT INTO tb_long(COL1)
VALUES('DSAFDHUSAIFHSJAFHSJKAFHDJKSAHFKJHSDAKJF');

SELECT * FROM tb_long;

SELECT COL1, LENGTHB(COL1)  -- LONG은 LENGTHB사용불가
FROM tb_long;

-- 책테이블
CREATE TABLE BOOK(
    TITLE VARCHAR2(20),
    BOOKCONTENT LONG,
    NO NUMBER,
    PRICE NUMBER
  --  COL2 LONG은 LONG한개, 하나의 테이블만 사용 가능  
);

-- 숫자(정수, 소수)
-- INTEGER 정수
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
VALUES('123', '456'); -- 문자열로 다가가도 상관없음
SELECT * FROM TB_INTEGER;

-- NUMBER 정수, 소수 가능
CREATE TABLE TB_NUMBER(
    COL1 NUMBER,
    COL2 NUMBER(5),-- 5자리
    COL3 NUMBER(5, 2),--5자리 소수2자리
    COL4 NUMBER(*,2)-- 자리무한, 소수 2자리
);

INSERT INTO TB_NUMBER(COL1, COL2, COL3, COL4)
VALUES(1234.5678, 12345.12, 123.456, 1234.5678);

SELECT * FROM TB_NUMBER;

-- 날짜 DATE
-- 연도, 월, 일, 시, 분, 초
CREATE TABLE TB_DATE(
    COL1 DATE,
    COL2 DATE
);

INSERT INTO TB_DATE(COL1, COL2)
VALUES(SYSDATE, SYSDATE - 1);

SELECT * FROM TB_DATE;
-- TO_DATE(날짜 문자열, 형식 문자열) 문자형을 데이터 형식으로 바꾼다
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
