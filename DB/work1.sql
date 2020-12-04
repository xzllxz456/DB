-- 모두조회
SELECT
    *
FROM employees;

-- 칼럼 조회 하기
    SELECT * FROM USER_TAB_COLUMNS;
-- 사원 번호, 이름, 급여, 담당업무 출력
SELECT employee_id, FIRST_NAME, SALARY, JOB_ID
FROM employees;
--모든 종업원의 급여를 $300증가 시키기 위해서 덧셈 연산자를 사용
-- 결과에 SALATY + 300을 디스플레이
SELECT FIRST_NAME, SALARY, SALARY+300
FROM employees;
--EMP 테이블에서 사원번호, 이름, 급여, 보너스, 보너스 금액을 출력하
--여라. (참고로 보너스는 월급 + (월급*커미션))
SELECT employee_id, FIRST_NAME, SALARY, COMMISSION_PCT*SALARY, SALARY+(COMMISSION_PCT*SALARY)
FROM employees;
--EMPLOYEES 테이블에서 LAST_NAME을 이름으로 SALARY을 급여로 출력하여라.

SELECT LAST_NAME "이름", SALARY "급여"
FROM employees;

--EMPLOYEES 테이블에서 LAST_NAME을 Name으로 
--SALARY *12를 Annual Salary(연봉)로 출력하여라
SELECT LAST_NAME "Name", SALARY*12 "Annual Salary"
FROM employees;
--EMPLOYEES 테이블에서 이름과 업무를 연결하여 출력하여라.
SELECT LAST_NAME || JOB_ID "emploryees"
FROM employees;

--EMPLOYEES 테이블에서 이름과 업무를
--“KING is a PRESIDENT” 형식으로 출력하여라.
SELECT LAST_NAME || ' is a JOB_ID' "Emploryees Details"
FROM employees;

--문제11) EMPLOYEES 테이블에서 이름과 연봉을
--“KING: 1 Year salary = 60000” 형식으로 출력하여라.

SELECT LAST_NAME || ': 1 Year salary = ' || SALARY*12 "MONTHLY"
FROM employees;

SELECT job_id
FROM employees;