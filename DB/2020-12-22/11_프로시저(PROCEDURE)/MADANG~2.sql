--PL/SQL 프로시저(PROCEDURE)
SET SERVEROUTPUT ON; --서버 출력정보 표시 설정

DECLARE -- 변수 선언
    V_EMPID NUMBER(5);
    V_NAME VARCHAR2(30);
BEGIN -- 실행문 시작
    V_EMPID := 100; -- 치환문(대입문) 부호 :=
    V_NAME := '홍길동';
    
    DBMS_OUTPUT.PUT_LINE(V_EMPID || ' : ' || V_NAME);

END; --실행문 끝(프로시저 끝)
-----------------------------------------
--BOOK 테이블 데이터 중 일부를 화면 출력
DECLARE
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
-- SELECT ~ INTO ~ FROM 형태로 DB데이터 선택하고 INTO절의 변수에 저장
-- (주의) 한개의 데이터만 처리가능
    SELECT BOOKID, BOOKNAME, PUBLISHER,PRICE
        INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = 1;
    
     DBMS_OUTPUT.PUT_LINE(V_BOOKID || ' , ' || V_BOOKNAME || ' , ' ||
            V_PUBLISHER   || ' , ' || V_PRICE  );
END;  

--===================================================
/* 저장 프로시저(Stored procedure) --호출해서 실행--SELECT 문에서 실행 불가 변수를 통해 값을 주고 받는다.
매개변수(파라미터, parameter) 유형
- IN : 입력을 받기만 하는 매개변수(기본값)
- OUT : 출력만 하는 매개변수
        (값을 받을 수는 없고, 프로시저 실행후 호출한 곳으로 변수를 통해 값 전달)
- IN OUT : 입력도 받고, 값을 변수를 통해 출력도 함
*******************************/
-- 프로시저 선언부(도입부)
CREATE OR REPLACE PROCEDURE BOOK_DISP
--매개변수 선언부 : ( )안에 작성, 구분문자  콤마사용(,) 
(
    IN_BOOKID IN NUMBER
)
AS -- 변수 선언부(AS 또는 IS ~ BEGIN 문 사이) 
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
SELECT BOOKID, BOOKNAME, PUBLISHER,PRICE
        INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;
    
     DBMS_OUTPUT.PUT_LINE(V_BOOKID || ' , ' || V_BOOKNAME || ' , ' ||
            V_PUBLISHER   || ' , ' || V_PRICE  );
END;

-- 프로시저 실행 : EXECUTE 프로시저명; 
EXECUTE BOOK_DISP(3);
EXEC BOOK_DISP(3);

-- 프로시저 삭제 : DROP PROCEDURE 프로시저명;
DROP PROCEDURE BOOK_DISP;