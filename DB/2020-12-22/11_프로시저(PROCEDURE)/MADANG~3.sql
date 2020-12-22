-- 프로시저 파라미터 유형 : IN, OUT 사용
create or replace PROCEDURE GET_BOOKINFO(
    IN_BOOKID IN NUMBER,
    OUT_BOOKNAME OUT VARCHAR2, -- 크기가 필요없다
    OUT_PUBLISHER OUT VARCHAR2,
    OUT_PRICE OUT NUMBER
) AS
-- %TYPE 사용 : 테이블명. 컬럼명%TYPE
-- 테이블 컬럼과 동일한 타입으로 선언(참조방식으로 적용)
    V_BOOKID BOOK.BOOKID%TYPE;
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER BOOK.PUBLISHER%TYPE;
    V_PRICE BOOK.PRICE%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('매개변수 값: ' || IN_BOOKID || ' , ' || OUT_BOOKNAME
                        || ' , ' || OUT_PUBLISHER   || ' , ' || OUT_PRICE);
             
SELECT BOOKID, BOOKNAME, PUBLISHER,PRICE
        INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;
    
    -- 호출한 곳으로 데이터를 전달하기 위해서 OUT유형의 변수에 저장
        OUT_BOOKNAME := V_BOOKNAME;
        OUT_PUBLISHER := V_PUBLISHER;
        OUT_PRICE := V_PRICE;
     DBMS_OUTPUT.PUT_LINE(V_BOOKID || ' , ' || V_BOOKNAME || ' , ' ||
            V_PUBLISHER   || ' , ' || V_PRICE  );

END;      
--===============================================================
-- 위의 프로시저를 호출해서 OUT으로 전달된 값 확인용 프로시저 
CREATE OR REPLACE PROCEDURE GET_BOOKINFO_TEST (
  IN_BOOKID IN NUMBER 
) AS 
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER BOOK.PUBLISHER%TYPE;
    V_PRICE BOOK.PRICE%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('입력받은 값(ID) : ' || IN_BOOKID);
    
    -- GET_BOOKINFO 프로시저 실행(호출)
    GET_BOOKINFO(IN_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE);
    
    -- GET_BOOKINFO 프로시저 실행(호출) 후 전달받은 값 확인 
    DBMS_OUTPUT.PUT_LINE('>>>>BOOKINFO OUT값 : ' || V_BOOKNAME
                                    || '/' || V_PUBLISHER || '/' || V_PRICE);
END GET_BOOKINFO_TEST;

--===================================================================================================================
/* (실습) 프로시저 작성하고 실행하기
고객테이블(CUSTOMER)에 있는 데이터 조회 프로시저 작성
- 프로시저명 : GET_CUSTINFO
- 입력받는 값 : 고객ID
- 처리 : 입력받은 고객ID에 해당하는 데이터를 찾아서 화면 출력
- 출력항목 : 고객ID, 고객명, 주소, 전화번호
********************************************/
CREATE OR REPLACE PROCEDURE GET_CUSTINFO(
    IN_CUSTID IN NUMBER
) AS
    V_CUSTID customer.custid%TYPE;
    V_NAME customer.name%TYPE;
    V_ADDRESS customer.address%TYPE;
    V_PHONE customer.phone%TYPE;

BEGIN
    SELECT CUSTID, NAME, ADDRESS, PHONE 
    INTO V_CUSTID, V_NAME, V_ADDRESS, V_PHONE
    FROM CUSTOMER
    WHERE custid = IN_CUSTID;
    
    DBMS_OUTPUT.PUT_LINE(V_CUSTID || ' . '||V_NAME|| ' . '||V_ADDRESS|| ' . '||V_PHONE);
END;
SET SERVEROUTPUT ON;
CALL GET_CUSTINFO(3);