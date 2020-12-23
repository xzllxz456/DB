/********** 트리거(TRIGGER) ******************
트리거(TRIGGER) : 특정 이벤트나 DDL, DML 문장이 실행되었을 때,
   자동적으로 어떤 일련의 동작(Operation)이나 처리를 수행하도록 하는
   데이타베이스 객체의 하나 -- 동작하는 시점
  -일반적으로 임의의 테이블에 데이타를 추가(NSERT), 삭제(DELETE), 수정(UPDATE) 할 때,
    다른 연관 관계에 있는 테이블의 데이타를 자동적으로 조작할 경우에 사용

CREATE [OR REPLACE] TRIGGER 트리거명
  BEFORE [OR AFTER]
  UPDATE [OR DELETE OR INSERT] ON 테이블명
  [FOR EACH ROW]
DECLARE
  변수선언부;
BEGIN
  프로그램 로직 구현부;
END;  
-------------------------------
<트리거 적용시기 지정>
BEFORE : 데이터 처리가 수행되기 전 수행(INSERT, UPDATE, DELETE 문 실행전)
AFTER : 데이터 처리가 수행된 후 수행(INSERT, UPDATE, DELETE 문 실행후)

이벤트 형태 지정 : INSERT, UPDATE, DELETE
이벤트 발생 테이블 지정 : ON 테이블명

<처리형태 지정>
FOR EACH ROW : 데이타 처리시 건건이 트리거 실행. 이 옵션이 없으면 
  기본값인 문장 레벨 트리거로 실행되며 수행전, 후에 한번씩만 트리거 실행

DECLARE : 변수 선언 시 사용 키워드
--------------------
<컬럼값 사용>
:OLD.컬럼명 : SQL 반영 전의 컬럼 데이타를 의미
:NEW.컬럼명 : SQL 반영 후의 컬럼 데이타를 의미
---------------------
<트리거 삭제, 활성, 비활성>
- 삭제 : DROP TRIGGER 트리거명;
- 활성 : ALTER TRIGGER 트리거명 enable;
- 비활성 : ALTER TRIGGER 트리거명 disable;
*****************************************/
-- BOOK 테이블에 대한 로그(LOG 이력 ) 남길 테이블 작성
CREATE TABLE BOOK_LOG(
     BOOKID NUMBER(5)
    ,BOOKNAME VARCHAR2(200)
    ,PUBLISHER VARCHAR2(300)
    ,PRICE VARCHAR2(200)
    ,LOGDATE DATE DEFAULT SYSDATE
    ,JOB_GUBUN VARCHAR2(10)
);
-- 트리거 작성
-- BOOK 테이블에 데이터가 입력(INSERT)되면 BOOK_LOG에 이력 남기기
-- 트리거명 : AFTER_INSERT_BOOK
CREATE OR REPLACE TRIGGER AFTER_INSERT_BOOK
    AFTER INSERT ON BOOK
    FOR EACH ROW
DECLARE
BEGIN
    -- 입력된 데이터 이력 남기기
    INSERT INTO BOOK_LOG
            (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
    VALUES(:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER, :NEW.PRICE, 'INSERT');
END;
------------------------------------
-- INSERT 트리거 동작 여부 확인
SELECT * FROM BOOK_LOG;
SELECT * FROM BOOK;
INSERT INTO BOOK VALUES(30, '데이터베이스의 이해', 'ITBOOK', 25000);
INSERT INTO BOOK VALUES(31, '데이터베이스의 이해2', 'ITBOOK', 25000);
INSERT INTO BOOK VALUES(32, '데이터베이스의 이해2', 'ITBOOK', 25000);
INSERT INTO BOOK VALUES(33, '데이터베이스의 이해3', 'ITBOOK', 775000);
COMMIT;
--====================================================================
-- UPDATE 트리거 작성 : AFTER_UPDATE_BOOK
CREATE OR REPLACE TRIGGER AFTER_UPDATE_BOOK 
    AFTER UPDATE ON BOOK 
    FOR EACH ROW
BEGIN
    -- 로그 남기기
    INSERT INTO BOOK_LOG
        (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
    VALUES(:OLD.BOOKID,
            :OLD.BOOKNAME || ' -> ' || :NEW.BOOKNAME,
            :OLD.PUBLISHER || ' -> ' || :NEW.PUBLISHER,
            :OLD.PRICE || ' -> ' || :NEW.PRICE,
            'UPDATE');
END;
-----------------------==============
-- UPDATE 트리거 테스트
SELECT * FROM BOOK;
SELECT * FROM BOOK_LOG;
UPDATE BOOK
    SET BOOKNAME = '오라클 데이터베이스의 이해2',
        PRICE = 35000
WHERE BOOKID = 31;
COMMIT;
SELECT * FROM BOOK_LOG;
--======================================
--(실습) DELETE 트리거 작성하고 동작 테스트 진행
-- 트리거명 : AFTER_DELETE_BOOK
-- 동작은 BOOK 테이블 데이터가 삭제되면 BOOK_LOG 테이블에 이력 남기기
---------------------------------------
CREATE OR REPLACE TRIGGER AFTER_DELETE_BOOK
    AFTER DELETE ON BOOK
    FOR EACH ROW
BEGIN
    INSERT INTO BOOK_LOG
        (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
    VALUES(:OLD.BOOKID, :OLD.BOOKNAME || '-> 삭제', :OLD.PUBLISHER, :OLD.PRICE , 'DELETE');
END;
---------------------
DELETE FROM book WHERE BOOKID = 30;
SELECT * FROM BOOK_LOG;
--===================
--insert, update, delete 작업시 동작하는 트리거
create or replace TRIGGER AFTER_BOOK_IUD
    AFTER INSERT OR UPDATE OR DELETE ON BOOK
    FOR EACH ROW
BEGIN
    -- INSERT 이벤트가 발생한 경우 로그 남기기
    IF INSERTING THEN
         INSERT INTO BOOK_LOG
            (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
         VALUES(:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER, :NEW.PRICE, 'INSERT_IUD');
    END IF;
        -- UPDATE 이벤트가 발생한 경우 로그 남기기
    IF UPDATING THEN
         INSERT INTO BOOK_LOG
            (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
            VALUES(:OLD.BOOKID,
                :OLD.BOOKNAME || ' -> ' || :NEW.BOOKNAME,
                :OLD.PUBLISHER || ' -> ' || :NEW.PUBLISHER,
                :OLD.PRICE || ' -> ' || :NEW.PRICE,
            'UPDATE_IUD');
    END IF;
    -- DELETE 이벤트가 발생한 경우 로그 남기기
    IF DELETING THEN
        INSERT INTO BOOK_LOG
            (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
        VALUES(:OLD.BOOKID, :OLD.BOOKNAME || '-> 삭제', :OLD.PUBLISHER, :OLD.PRICE , 'DELETE_IUD');
    END IF;
END;

--==============================================
SELECT * FROM BOOK;
SELECT * FROM BOOK_LOG;
UPDATE BOOK
    SET BOOKNAME = '오라클 데이터베이스의 이해9',
        PRICE = 35000
WHERE BOOKID = 33;
COMMIT;
SELECT * FROM BOOK_LOG;
DELETE FROM book WHERE BOOKID = 32;