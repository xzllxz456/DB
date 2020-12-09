/*
    SUM, AVG, COUNT, MAX, MIN 으로 통계
*/
SELECT COUNT(salary), SUM(salary),AVG(salary), SUM(salary)/COUNT(salary)
FROM employees
WHERE job_id = 'IT_PROG';

/*
SELECT employee_id, COUNT(salary), SUM(salary)
FROM employees;-- 일반 컬럼하고 섞어서 사용 불가
WHERE job_id = 'IT_PROG';
*/

/*
    GROUP BY, HAVING
*/
SELECT DISTINCT department_id -- 컬럼으로쓴다
FROM employees
ORDER BY department_id ASC; -- 중복제거

SELECT department_id
FROM employees
GROUP BY department_id; -- 그룹으로 묶인다
-- ORDER BY department_id ASC;
/*
SELECT job_id, employee_id -- 그룹으로 묶은걸 한명한명 표현이 불가능하기때문에 사용 불가
FROM employees
GROUP BY job_id;
*/

SELECT job_id, SUM(salary), AVG(salary)
FROM employees
GROUP BY job_id
HAVING SUM(salary) >= 10000;     -- 조건절     -- GROUP BY절이 반드시 필요

/*
    NVL(대상이 되는 컬럼, 지정값) NUMBER
    대상이 되는 컬럼 != NULL   --> 대상이 되는 컬럼
    대상이 되는 컬럼 == NULL   --> 지정값
*/

SELECT first_name, NVL(commission_pct,0)
FROM employees;

/*
    NVL2(대상이 되는 컬럼, 값1, 값2)
    대상이 되는 컬럼 != NULL      --> 값1
    대상이 되는 컬럼 == NULL      --> 값2
*/

SELECT first_name, NVL2(commission_pct, 1, 0)
FROM employees;

-- 급여가 5000이상 받는 사원만으로 합계를 내서 업무로 그룹화하여 급여 합계가 2000을 초과하는 업무명을 구하라.
SELECT job_id, SUM(salary)
FROM employees
WHERE salary >= 5000
GROUP BY job_id
HAVING SUM(salary) > 20000;

SELECT job_id, count(salary), sum(salary), round(avg(salary))
FROM employees
WHERE salary > 5000
GROUP BY job_id
HAVING SUM(salary) > 20000;

--문제1) EMPLOYEES 테이블에서 King의 정보를 소문자로 검색하고 사원번호,
--성명, 담당업무(소문자로),부서번호를 출력하라.
SELECT employee_id, last_name, LOWER(job_id), department_id
FROM employees
WHERE LOWER(last_name) LIKE LOWER('king');

--문제2) EMPLOYEES 테이블에서 King의 정보를 대문자로 검색하고 사원번호,
--성명, 담당업무(대문자로),부서번호를 출력하라.
SELECT employee_id, last_name, UPPER(job_id), department_id
FROM employees
WHERE UPPER(last_name) LIKE UPPER('KING');

-- 문제3) DEPARTMENTS 테이블에서 부서번호와 부서이름, 부서이름과 위치번
-- 호를 합하여 출력하도록 하라.
SELECT department_id || ' ' ||department_name,department_name|| ' '||location_id,
    CONCAT(department_id, department_name),
    CONCAT(department_name, location_id)
FROM departments;

--문제4) EMPLOYEES 테이블에서 이름의 첫 글자가 ‘K’ 보다 크고 ‘Y’보다 적은
--사원의 정보를 사원번호, 이름, 업무, 급여, 부서번호를 출력하라.
--단 이름순으로 정렬하여라.

SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE last_name > 'K%' AND last_name < 'Y%'
ORDER BY last_name asc;

SELECT Employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE SUBSTR(last_name, 1, 1) > 'K' AND SUBSTR(last_name, 1, 1) < 'Y'
ORDER BY last_name asc;
--문제5) EMPLOYEES 테이블에서 20번 부서 중 이름의 길이 및 급여의 자릿수
--를 사원번호, 이름, 이름의 자릿수, 급여, 급여의 자릿수를 출력하라.

SELECT department_id, employee_id, last_name, LENGTH(last_name), salary, LENGTH(salary)
FROM employees
WHERE department_id = 20;

-- 문제6) EMPLOYEES 테이블에서 이름 중 ‘e’자의 위치를 출력하라.
SELECT last_name, INSTR(last_name, 'e'),INSTR(last_name, 'e',1,2)
FROM employees;

SELECT first_name, INSTR(first_name, 'e'),INSTR(first_name, 'e',1,2)
FROM employees;
-- 문제7) 다음의 쿼리를 실행하고 결과를 분석하라.

SELECT ROUND(4567.678),ROUND(4567.678,0), -- 반올림 해서 자름 ,2는 소수점 2개, -2는 앞으로 2개
ROUND(4567.678,2),ROUND(4567.678,-2)
FROM dual;

--문제8) EMPLOYEES 테이블에서 부서번호가 80인 사람의 급여를 30으로 나눈
-- 나머지를 구하여 출력하라.
SELECT department_id, round(salary/30, 5)
FROM employees
WHERE department_id = 80;

SELECT first_name,salary, MOD(salary,30), department_id
FROM employees
WHERE department_id = 80;

--문제9) EMPLOYEES 테이블에서 30번 부서 중 이름과 담당 업무를 연결하여
--출력하여라. 단 담당 업무를 한 줄 아래로 출력하라.
--보이기엔 한줄처럼 보이지만 그리드를 더블 클릭하면 개행 되었다는 것을 확인할 수 있습니다.
SELECT employee_id, last_name, job_id, last_name || CHR(10) || job_id
FROM employees
WHERE department_id like 30;

--문제10) EMPLOYEES 테이블에서 현재까지 근무일 수가 몇주 몇일 인가를 출
--력하여라. 단 근무 일수가 많은 사람 순으로 출력하여라.
SELECT last_name, round ((SYSDATE-hire_date)/7,0) "주", round (SYSDATE-hire_date) "일"
FROM employees
ORDER BY SYSDATE-hire_date DESC;

SELECT first_name, hire_date, 
    to_date(SYSDATE) - hire_date AS "총 근무 일수",    -- 입사한 후에 몇 일간 근무 했는지? 
    trunc( (to_date(SYSDATE) - hire_date) / 7) AS "총 근무 주일수",   -- 입사한 후에 몇 주간 근무 했는지?  
    mod( (to_date(SYSDATE) - hire_date), 7) as "남은 일수" 
  
FROM employees 
ORDER BY "총 근무 일수" DESC;

SELECT last_name, hire_date, SYSDATE,
    trunc(SYSDATE - hire_date),  -- 버림함수
    trunc((SYSDATE - hire_date)/7), -- 총 근무 주
      ROUND(MOD((SYSDATE - hire_date), 7)) -- 총근무일수 - 총근무주 = 나머지일수
FROM employees
ORDER BY SYSDATE - hire_date DESC;

-- 문제11) EMPLOYEES 테이블에서 부서 50에서 급여 앞에 $를 삽입하고 3자리
-- 마다 ,를 출력하라
SELECT department_id, last_name,salary, TO_CHAR( salary, '$999,999,999')
FROM employees
WHERE department_id = 50;

--문제1) EMPLOYEES 테이블에서 업무로 모든 SA에 대하여 급여의 평균, 최고액, 최저액, 합계를 구하여 출력하여라.
SELECT job_id, AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
GROUP BY job_id;

--문제2) EMPLOYEES 테이블에서 부서별로 인원수, 평균 급여, 최저급여, 최고 급여, 급여의 합을 구하여 출력하라.
SELECT job_id, COUNT(job_id),AVG(salary), MIN(salary), MAX(salary), SUM(salary)
FROM employees
GROUP BY job_id;

--문제3) EMPLOYEES 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 구하여 출력하여라.
SELECT job_id, department_id, COUNT(job_id), SUM(salary)
FROM employees
GROUP BY department_id, job_id
HAVING COUNT(job_id) > 4;

--문제4) EMPLOYEES 테이블에서 급여가 최대 10000이상인 부서에 대해서 부서번호, 평균 급여, 급여의 합을 구하여 출력하여라.
SELECT department_id, SUM(salary), ROUND(AVG(SALARY))
FROM employees
GROUP BY department_id
HAVING MAX(salary) >= 10000;


--문제5) EMPLOYEES 테이블에서 전체 월급이 10000을 초과하는 각 업무에 대해서 업무와 월급여 합계를 출력하라. 
--단 판매원(SA)은 제외하고 월 급여 합계로 정렬(내림차순)하라.
SELECT job_id,COUNT(*), SUM(salary), AVG(salary)
FROM employees
GROUP BY job_id
HAVING AVG(salary) > 10000;

