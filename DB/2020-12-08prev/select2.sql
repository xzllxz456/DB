select * from emp;

-- 현재 스키마의 모든 테이블
select * from tab; 

-- 테이블의 컬럼들을 출력한다
DESC emp; 

SELECT empno, ename, sal FROM emp;

-- dual : 가상테이블
SELECT SYSDATE FROM DUAL;
SELECT 4 * 7 FROM DUAL;
SELECT '4' * 7 FROM DUAL;
SELECT '4' * '7' FROM DUAL;

SELECT 'HELLO' || ' ' || 'ORACLE' FROM DUAL;

SELECT ROUND(10.5) FROM DUAL;

SELECT ename, sal, sal * 12 FROM emp;

-- alias (컬럼정보)
SELECT ename AS 이름, sal, sal * 12
FROM emp;
SELECT ename AS "이 름", sal as "월급", sal * 12 연봉 -- as 붙이는게 좋다(명시적임)
FROM emp;

-- DISTINCT : 중복행 삭제 --> group by
SELECT deptno
FROM emp;
SELECT DISTINCT deptno
FROM emp;

SELECT job
from emp;
SELECT DISTINCT job
from emp;

-- 1) emp 테이블에서 사원번호, 사원이름, 월급을 출력하시오.
SELECT empno,ename,sal 
FROM emp;
-- 2) emp 테이블에서 사원이름과 월급을 출력하는데 컬럼명은 이 름, 월 급으로 바꿔서 출력하시오.
SELECT ename as "이 름", sal as "월 급"
from emp;
-- 3) emp 테이블에서 사원번호, 사원이름, 월급, 연봉을 구하고 각각 컬럼명은 사원번호, 사원이름, 월급, 연봉으로 출력하시오
SELECT empno as "사원번호", ename as "사원이름" ,sal as "월 급",sal * 12 as "연봉"
from emp;
-- 4) emp 테이블에서 업무(job)를 중복되지 않게 표시하시오.
SELECT DISTINCT job
from emp;
-- 5) emp 테이블의 사원명과 업무로 연결(SMITH, CHECK)해서 표시하고 컬럼명은 Employee and Job으로 표시하시오
SELECT (ename || 'SMITH'||'   ,   '|| job|| 'CHECK') "Employee and Job"
from emp;