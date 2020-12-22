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