/*
    Table
        가로(row), 세로(colum)
    
        create
        drop
        alter
        update
    
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
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT * FROM tb_deptgroup;

-- TABLE COPY : 데이터 미포함
CREATE TABLE TB_TEST04
AS
SELECT *
FROM departments
WHERE 1 = 2;

SELECT * FROM tb_test04;

CREATE TABLE DEPT_EMP(empno, sal, dname, loc)
AS
SELECT e.employee_id, e.salary, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND 1 = 2;
    
-- 테이블 수정

-- 테이블 명 수정
ALTER TABLE TB_TEST04
RENAME TO TB_TEST99;

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
(NEWCOL VARCHAR2(20), COLNEW2 VARCHAR2(30));

-- 컬럼 삭제
ALTER TABLE TB_TEST99
DROP
COLUMN NEWCOL;

-- 다증 컬럼 삭제
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