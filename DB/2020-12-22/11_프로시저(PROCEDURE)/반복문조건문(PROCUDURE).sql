/* 비교구문 (분기처리) IF문
IF(조건식) THEN ~ END IF;
IF(조건식) THEN ~ ELSE ~ END IF;
IF(조건식) THEN ~ ELSEIF ~ ELSEIF ~ ELSE ~ END IF;
************************************/
-- 홀수, 짝수 판별
create or replace PROCEDURE PRC_IF(
    IN_NUM IN NUMBER
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>>입력값 : ' || IN_NUM);
    -- 홀짝 판별(숫자를 2로 나눈 나머지가 0이면 짝수)
    IF(MOD(IN_NUM, 2) = 0) THEN 
        DBMS_OUTPUT.PUT_LINE(IN_NUM || '짝수');
    ELSE
        DBMS_OUTPUT.PUT_LINE(IN_NUM || '홀수');
    END IF;
END;

--============
--입력받은 숫자값을 4로 나눈 나머지 값 확인
create or replace PROCEDURE PRC_IF2(
    IN_NUM IN NUMBER
) AS
BEGIN
     DBMS_OUTPUT.PUT_LINE('>>>입력값 : ' || IN_NUM);
     -- 4로 나눈 나머지 값 출력
     IF(MOD(IN_NUM, 4) = 0) THEN
         DBMS_OUTPUT.PUT_LINE('>>>4로 나눈 나머지 0');
     ELSIF(MOD(IN_NUM, 4) = 1) THEN
        DBMS_OUTPUT.PUT_LINE('>>>4로 나눈 나머지 1');  
     ELSIF(MOD(IN_NUM, 4) = 2) THEN
        DBMS_OUTPUT.PUT_LINE('>>>4로 나눈 나머지 2');
     ELSE
        DBMS_OUTPUT.PUT_LINE('>>>4로 나눈 나머지 3');
     END IF;
END;

--================================
-- 반복문 : FOR, WHILE 
-- FOR문
---- FOR 변수 IN CHRLRKQT .. 최종값 LOOP ~ END LOOP;
------------------------------------------------
-- 숫자 하나를 입력 받아서 합계 출력(1~10 까지 합)
CREATE OR REPLACE PROCEDURE PRC_FOR_SUM(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0; -- 변수 선언 및 초기화 (초기값 0)
BEGIN
    -- 입력받은 값 화면 출력
    DBMS_OUTPUT.PUT_LINE('>>> 입력값 : ' || IN_NUM);
    
    -- 누적 : FOR문으로 반복문 처리
    FOR I IN 1 .. IN_NUM LOOP
    V_SUM := V_SUM + I;
     DBMS_OUTPUT.PUT_LINE('>>> I : ' || I);
    END LOOP;
   -- DBMS_OUTPUT.PUT_LINE('>>> 출력값 : 1 부터'|| IN_NUM || ' 까지의 합계 : ' || V_SUM);
    DBMS_OUTPUT.PUT('>>> 출력값 : 1 부터'|| IN_NUM || ' 까지의 합계 : ');
     DBMS_OUTPUT.PUT_LINE(V_SUM);
END;
SET SERVEROUTPUT ON;
CALL PRC_FOR_SUM(10);

--==========================
-- WHILE 문
-- WHILE (조건식) LOOP ~ END LOOP;
-- 숫자 하나를 입력 받아서 합계 출력(1~10 까지 합)
create or replace PROCEDURE PRC_WHILE_SUM(
    IN_NUM NUMBER -- IN 생략 가능    
) AS
    V_SUM NUMBER := 0;
    I NUMBER := 1;
BEGIN
    --입력 받은 값 출력
    DBMS_OUTPUT.PUT_LINE('>>> 입력값 : ' || IN_NUM);
    
    WHILE(I <= IN_NUM) LOOP 
    V_SUM := V_SUM + I;
    I := I + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~ ' || IN_NUM || '까지 합계 : ' || V_SUM);
END;

--==================================================
/* LOOP ~ END LOOP;
LOOP
    EXIT WHEN (종결 조건식);
END LOOP;
****************************************/
CREATE OR REPLACE PROCEDURE LOOP1
AS 
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
        EXIT WHEN (I = 10); -- =, <>, !=, >, <, <=, >=
        I := I + 1;
    END LOOP;
END;

--====================================
/* (실습) 숫자를 하나 입력 받아서 1 ~ 숫자까지의 합계 구하기
프로시저명 : PRC_SUM_EVENODD
? 입력값이 홀수면 홀수값만 더하고
? 입력값이 짝수면 짝수값만 더해서
최종 합계값을 화면에 출력
<출력형태>
? 입력숫자: 입력값, 홀수/짝수, 합계 : 합계결과
   출력예) 입력숫자 : 4, 짝수, 합계 : 6
   출력예) 입력숫자 : 5, 홀수, 합계 : 9
******************************************/
CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD(
    IN_NUM IN NUMBER
)
AS
    V_SUM NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM,2) = 0) THEN
        DBMS_OUTPUT.PUT(', 짝수');
    ELSE
         DBMS_OUTPUT.PUT(', 홀수');
    END IF;
    FOR I IN 1 .. IN_NUM LOOP
        IF(MOD(IN_NUM,2) = 0 AND MOD(I, 2) = 0) THEN
            V_SUM := V_SUM + I;
        ELSIF (MOD(IN_NUM,2) = 1 AND MOD(I, 2) = 1) THEN
            V_SUM := V_SUM + I;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(', 합계 : ' || V_SUM);
END;
CALL PRC_SUM_EVENODD(5);

CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD2(IN_NUM NUMBER)
AS
    START_NUM NUMBER;
    V_SUM NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT('입력숫자 : ' || IN_NUM);
    START_NUM := MOD(IN_NUM, 2);
    IF(START_NUM = 0) THEN
        START_NUM := 2;
        DBMS_OUTPUT.PUT(', 짝수');
    ELSE
        DBMS_OUTPUT.PUT(', 홀수');
    END IF;
    WHILE (START_NUM <= IN_NUM) LOOP
        V_SUM := V_SUM + START_NUM;
        START_NUM := START_NUM + 2;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(', 합계 : ' || V_SUM);
END;

CALL PRC_SUM_EVENODD2(5);

CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD3(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    V_EVENNODD VARCHAR2(50) := '홀수';
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM, 2) = 0) THEN
       V_EVENNODD := '짝수';
    END IF;
    DBMS_OUTPUT.PUT('홀짝구분 : ' || V_EVENNODD);
    
    FOR I IN 1 .. IN_NUM LOOP
        -- 짝수일때
        IF(MOD(I, 2) = 0 AND V_EVENNODD = '짝수') THEN
            V_SUM := V_SUM + I;
        END IF;
        -- 홀수일때
        IF(MOD(I, 2) <> 0 AND V_EVENNODD = '홀수') THEN
        V_SUM := V_SUM + I;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('입력값 : ' || IN_NUM || ' , ' || 
                   V_EVENNODD || ', 합계 : ' || V_SUM );
END;

create or replace PROCEDURE PRC_SUM_EVENODD4(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    V_EVENNODD VARCHAR2(50) := '홀수';
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM, 2) = 0) THEN
       V_EVENNODD := '짝수';
    END IF;
    DBMS_OUTPUT.PUT('홀짝구분 : ' || V_EVENNODD);

    FOR I IN 1 .. IN_NUM LOOP
        -- 짝수일때 짝수값 더하기 홀수일때 홀수값 더하기
        IF(MOD(IN_NUM, 2) = MOD(I, 2)) THEN
            V_SUM := V_SUM + I;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('입력값 : ' || IN_NUM || ' , ' || 
                   V_EVENNODD || ', 합계 : ' || V_SUM );
END;

create or replace PROCEDURE PRC_SUM_EVENODD5(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    V_EVENNODD VARCHAR2(50) := '홀수';
    I NUMBER := 1; --홀수일때 시작 번호
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM, 2) = 0) THEN
       V_EVENNODD := '짝수';
       I := 2; -- 짝수일때 시작값
    END IF;
    WHILE (I <= IN_NUM) LOOP
        V_SUM := V_SUM + I;
        I := I + 2;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('입력값 : ' || IN_NUM || ' , ' || 
                   V_EVENNODD || ', 합계 : ' || V_SUM );
END;