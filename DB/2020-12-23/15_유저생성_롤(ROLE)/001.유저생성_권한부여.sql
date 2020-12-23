/* ********* 사용자 생성, 삭제 *********
-- 사용자 생성 : CREATE USER
CREATE USER 사용자명(유저명) --"MDGUEST" 
IDENTIFIED BY 비밀번호 --"mdguest"  
DEFAULT TABLESPACE 테이블스페이스 --"USERS"
TEMPORARY TABLESPACE 임시작업테이블스페이스 --"TEMP";

-- 사용할 용량 지정(수정)
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";

-- 사용자 수정 : ALTER USER 
ALTER USER 사용자명(유저명) IDENTIFIED BY 비밀번호;

-- 권한부여(롤 사용 권한 부여, 롤 부여)
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;

-- 사용자 삭제 : DROP USER
DROP USER 유저명 [CASCADE];
--CASCADE : 삭제시점에 사용자(유저)가 보유한 모든 데이타 삭제
*************************************/

--(관리자계정 SYSTEM) 유저생성 권한을 가진 SYSTEM에서 작업
-- 유저명MDGUEST 패스워드 : mdguest
-- USER SQL
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

-- ROLES 롤(역활)부여 : GRANT
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
GRANT CONNECT, RESOURCE TO MDGUEST;

-- 뷰 생성 권한 부여
GRANT CREATE VIEW TO "MDGUEST" ;
-------------------------------------
--(SYSTEM) CONNECT, RESOURCE 롤(ROLE)에 있는 권한 확인
SELECT *
 FROM DBA_SYS_PRIVS
 WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
 ORDER BY GRANTEE, PRIVILEGE;






--=============================
/****** 권한 부여(GRANT), 권한 취소(REVOKE) **********************
GRANT 권한 [ON 객체] TO {사용자|ROLE|PUBLIC,.., n} [WITH GRANT OPTION]
--PUBLIC은 모든 사용자에게 적용을 의미

GRANT 권한 TO 사용자; --권한을 사용자에게 부여
GRANT 권한 ON 객체 TO 사용자; -객체에 대한 권한을 사용자에게 부여
-->> WITH GRANT OPTION :객체에 대한 권한을 사용자에게 부여 
-- 권한을 받은 사용자가 다른 사용자에게 권한부여할 권리 포함
GRANT 권한 ON 객체 TO 사용자 WITH GRANT OPTION;
--------------------
-->>>권한 취소(REVOKE)
REVOKE 권한 [ON 객체] FROM {사용자|ROLE|PUBLIC,.., n} CASCADE
--CASCADE는 사용자가 다른 사용자에게 부여한 권한까지 취소시킴
  (확인 및 검증 후 작업)

REVOKE 권한 FROM 사용자; --권한을 사용자에게 부여
REVOKE 권한 ON 객체 FROM 사용자; -객체에 대한 권한을 사용자에게 부여
*************************************************/
-- 권한부여 : MADANG 유저의 BOOK 테이블에 대한 SELECT 권한을 MDGUEST에게 부여
-----(SYSTEM) 권한부여 -MADANG.BOOK
SELECT * FROM MADANG.BOOK;
GRANT SELECT ON MADANG.BOOK TO MDGUEST;
---- (MDGUEST) MADANG.BOOK. 테이블 데이터 조회(SELECT) 할수있음
SELECT * FROM MADANG.BOOK;
SELECT * FROM MADANG.CUSTOMER; -- 권한이 없어 접근 불가
-- (SYSTEM) 권한 회수(REVOKE) - MADANG.BOOK
REVOKE SELECT ON MADANG.BOOK FROM MDGUEST;
--========================
--(MADANG유저에서) CUSTOMER 테이블에 대하여 MDGUEST 유저에게 
-- SELECT, UPDATE 권한 부여
GRANT SELECT, UPDATE ON MADANG.CUSTOMER TO MDGUEST;
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST;
-- (MDGUEST에서) CUSTOMER 테이블 SELECT, UPDATE
-- 권한을 부여 받아서 SELECT, UPDATE 가능
SELECT * FROM MADANG.CUSTOMER;
UPDATE MADANG.CUSTOMER
    SET PHONE = '010-1111-2222'
WHERE NAME = '박세리';

DELETE FROM MADANG.CUSTOMER WHERE NAME = '박세리';

-- 권한 취소 : REVOKE
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST;
----------------------------------------
-- WITH GRANT OPTION : 다른 유저에게 권한을 부여할 수 있도록 허용
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION;
--(MDGUEST) 다른 유저에게 권한 부여
GRANT SELECT, UPDATE ON MADANG.CUSTOMER TO HR;
-- (hr) MADANG.CUSTOMER SELECT
SELECT * FROM MADANG.CUSTOMER;
SELECT * FROM MADANG.BOOK; -- 권한 없음ORA-00942: table or view does not exist
--(MADANG) MDGUEST 권한 회수
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST;
--========================================================
--(관리자 SYSTEM에서 ) 유저 삭제
DROP USER MDGUEST CASCADE;