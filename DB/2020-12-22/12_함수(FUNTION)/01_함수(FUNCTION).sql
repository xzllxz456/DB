/* 함수(FUNCTION)
실행 후 값을 리턴(RETURN) 하는 프로그램 -- 리턴이 필수
CREATE OR REPLACE FUNCTION FUNCTION1 
(
  PARAM1 IN VARCHAR2 -- 파라미터 작성
) RETURN VARCHAR2 AS  -- 리턴 데이터 타입 선언
BEGIN
  RETURN NULL; -- 리턴 값
END;
************************************/
-- BOOKID로 책제목 확인 함수(파라미터값 : BOOKID, RETURN값 : BOOKNAME)
create or replace FUNCTION GET_BOOKNAME(
    IN_ID IN NUMBER
) RETURN VARCHAR2 AS
    V_BOOKNAME book.bookname%TYPE;
BEGIN
    --DBMS_OUTPUT.PUT_LINE('IN_ID : ' || IN_ID);
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    RETURN V_BOOKNAME;  --  리턴값 전달 (책 제목)
END;
-------------------------------------------
-- 함수의 사용
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID) BOOKNAME
FROM BOOK;
------------
--SELECT 절에 사용자 함수 사용
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME
FROM ORDERS O;

-- WHERE 절에 사용
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME
FROM ORDERS O
WHERE GET_BOOKNAME(O.BOOKID) = '야구를 부탁해'
;
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME
FROM ORDERS O
WHERE GET_BOOKNAME(O.BOOKID) = '역도 단계별기술'
;

--====================================
/* (실습) 고객ID 값을 받아서 고객명을 돌려주는 함수 작성(CUSTOMER 테이블 사용)
함수명 : GET_CUSTNAME
함수를 사용해서 ORDERS 테이블 데이터 조회
    GET_BOOKNAME, GET_CUSTNAME 함수사용 주문(판매)정보와 책제목, 고객명 조회
***************************************/
CREATE OR REPLACE FUNCTION GET_CUSTNAME(
    IN_ID NUMBER
)RETURN VARCHAR2
AS
   -- V_BOOKNAME book.bookname%TYPE;
    V_NAME customer.name%TYPE;
BEGIN
    SELECT NAME INTO V_NAME FROM CUSTOMER WHERE CUSTID = IN_ID;
    RETURN V_NAME;
END;
SET SERVEROUT ON;
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME , GET_CUSTNAME2(O.CUSTID) CUSTNAME
FROM ORDERS O;
SELECT O.*, 
    (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME,
    GET_CUSTNAME2(O.CUSTID) CUSTNAME
FROM ORDERS O;
CALL GET_CUSTNAME2(1);

CREATE OR REPLACE FUNCTION GET_CUSTNAME2(IN_CUSTID NUMBER)
    RETURN VARCHAR2
AS
    V_NAME CUSTOMER.NAME%TYPE;
BEGIN
    SELECT NAME
    INTO V_NAME
    FROM CUSTOMER
    WHERE CUSTID = IN_CUSTID;
    
    DBMS_OUTPUT.PUT_LINE('냥냥 펀치~~!');
    RETURN V_NAME;
end;

--------------------------------------------------------
SELECT O.*, b.bookid, c.name
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE o.bookid = b.bookid -- 조인조건
AND o.custid = c.custid -- 조인조건
AND C.NAME = '박지성' -- WHERE 조건
;
-------
SELECT O.*, b.bookid, c.name
FROM ORDERS O INNER JOIN BOOK B
    ON O.BOOKID = B.BOOKID -- 조인조건
    JOIN CUSTOMER C
    ON O.CUSTID = C.CUSTID -- 조인조건
WHERE C.NAME = '박지성' -- WHERE 조건
;
--------------------------------------
