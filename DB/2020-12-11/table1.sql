
/*
    Table
        가로(row), 세로(column)        
        create
        drop
        alter
    
        Data
            insert
            delete
            select
            update        
*/

CREATE TABLE TB_TEST01(
    COL1 VARCHAR2(10),
    COL2 VARCHAR2(10),
    COL3 VARCHAR2(10)
);

DROP TABLE TB_TEST01;

CREATE TABLE TB_TEST02(
    COL1 VARCHAR2(10),
    COL2 NUMBER(5, 1),
    COL3 DATE
);

-- TABLE COPY : 데이터 포함
CREATE TABLE TB_TEST03
AS
SELECT *
FROM employees;

SELECT * FROM tb_test03;

DROP TABLE TB_TEST03;

CREATE TABLE TB_TEST03(empno, ename, sal)
AS
SELECT employee_id, first_name, salary
FROM employees;

CREATE TABLE TB_DEPTGROUP(dnum, dcount)
AS
SELECT department_id, count(*)
FROM employees
GROUP BY department_id;

SELECT * FROM TB_DEPTGROUP;

-- TABLE COPY : 데이터 미포함
CREATE TABLE TB_TEST04
AS
SELECT *
FROM departments
WHERE 1 = 2;

SELECT * FROM TB_TEST04;

CREATE TABLE DEPT_EMP(empno, sal, dname, loc)
AS
SELECT e.employee_id, e.salary, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND 1 = 2;

-- 데이블 수정

-- 테이블명 수정
ALTER TABLE TB_TEST04 
RENAME 
TO
TB_TEST99;

-- 단일 컬럼을 추가
ALTER TABLE TB_TEST99
ADD
NEWCOL VARCHAR2(20);

-- 다중 컬럼을 추가
ALTER TABLE TB_TEST99
ADD
(COLNEW1 NUMBER, COLNEW2 DATE);

-- 단일 컬럼 수정
ALTER TABLE TB_TEST99
MODIFY
NEWCOL VARCHAR2(30);

-- 다중 컬럼 수정
ALTER TABLE TB_TEST99
MODIFY
(COLNEW1 VARCHAR2(20), COLNEW2 VARCHAR2(30));

-- 컬럼 삭제
ALTER TABLE TB_TEST99
DROP
COLUMN NEWCOL;

ALTER TABLE TB_TEST99
DROP
(COLNEW1, COLNEW2);

-- 컬럼명 수정
ALTER TABLE TB_TEST99
RENAME
COLUMN
DEPARTMENT_ID TO DEPTNO;

DROP TABLE TB_TEST99;

-- 휴지통 비우기
PURGE RECYCLEBIN;

-- INSERT
INSERT INTO TB_TEST04 (department_id, department_name, manager_id, location_id)
VALUES(100, '기획부', 20, 200 );
SELECT * FROM tb_test04;

INSERT INTO TB_TEST04 (department_id, department_name)
VALUES(100, '기획부');

INSERT INTO tb_test04
VALUES(101,'관리부', 30, 400);

INSERT INTO TB_TEST04 ( manager_id, location_id,department_id, department_name)
VALUES(50,500,102,'영업부');
-- DELETE
DELETE FROM tb_test04
WHERE manager_id IS NULL;
-- UPDATE
UPDATE tb_test04
SET manager_id = 40
WHERE department_name = '영업부';

UPDATE tb_test04
SET manager_id = 10, location_id = 100, department_id = 1000
--WHERE department_name = '관리부';
WHERE department_id > 100;

--문제1) EMPLOYEES 테이블에서 부서별로 인원수,평균 급여,급여의 합,최소 급여,
-- 최대 급여를 포함하는 EMP_DEPTNO 테이블을 생성하라.
CREATE TABLE EMP_DEPTNO("부서1","인원수1","평균급여1","급여 합","최대급여","최소급여")
AS
SELECT department_id, COUNT(employee_id), AVG(salary), SUM(salary),
                MAX(salary),MIN(salary)
FROM employees
GROUP BY department_id;
--DROP TABLE EMP_DEPTNO;

--문제2) EMP_DEPTNO 테이블에 ETC COLUMN을 추가하라.
--단 자료형은 VARCHAR2(50) 사용하라.
ALTER TABLE EMP_DEPTNO
ADD
ETC VARCHAR2(50);
ALTER TABLE EMP_DEPTNO
DROP
COLUMN ETC;

--문제3) EMP_DEPTNO 테이블에 ETC COLUMN을 수정하라.
--자료 형은 VARCHAR2(15)로 하라.
ALTER TABLE EMP_DEPTNO
MODIFY
ETC VARCHAR2(15);

-- 문제4) EMP_DEPTNO 테이블에 있는 ETC 을 삭제하고 확인하라.
ALTER TABLE EMP_DEPTNO
DROP
COLUMN ETC;

--문제5) 이전에 생성한 EMP_DEPTNO 테이블의 이름을 EMP_DEPT로 변경하라.

ALTER TABLE EMP_DEPTNO 
RENAME 
TO
EMP_DEPT;

--문제6) EMP_DEPT 테이블을 삭제하라.
DROP TABLE EMP_DEPT;

--문제7) EMPLOYEES 테이블을 EMP 테이블을 생성하고 복제하도록 하라. (데이터 포함)
CREATE TABLE EMP
AS
SELECT
    *
FROM employees;

--문제8) EMP 테이블에 row를 추가해 봅니다.
--다만, 반드시 데이터를 기입을 안해도 되면, NULL로 설정하도록 한다.
INSERT INTO EMP
VALUES(277, null, 'ONYOU', 'http200', null, '14/11/13', 'hello', 25000, null, null, null);
--문제9) EMPLOYEES 테이블에서 EMPNO,ENAME,SAL,HIREDATE의 COLUMN만
--선택하여 EMP_10 테이블을 생성(데이터 미포함)한 후 10번 부서만 선택하여
--이에 대응하는 값을 EMP_10테이블에 입력하라.
CREATE TABLE EMP_10
AS
SELECT employee_id ,last_name, salary, hire_date 
FROM employees
WHERE 1=2;
insert INTO emp_10                                                
SELECT
    employee_id ,last_name, salary, hire_date
FROM employees
where department_id = 10;

--문제10) 다음은 무결성 제약 조건이 위배된 쿼리이다.
--무엇을 위배했는지 알아보도록 합시다.

INSERT INTO emp_10
VALUES (100, NULL, 'YOON', 'dbs', NULL, SYSDATE, 'ST_MAN', NULL, NULL,
NULL, NULL); -- 100 번 이미 존재

INSERT INTO EMP_10
VALUES (98, NULL, 'YOON', 'dbs', NULL, SYSDATE, 'ST_MAN', NULL, NULL,
NULL, 100);-- EMAIL위에서 이미 추가, 이미 존재

INSERT INTO EMP_10
VALUES (98, NULL, 'YOON', 'dbs2', NULL, SYSDATE, 'ST_MAN', NULL, NULL,
NULL, 101); -- 외랴키 존재 X

