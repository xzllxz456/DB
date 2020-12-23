/*  
    순위 함수
    RANK()          1 2 3 3 5 6   1 2 3 3 3 6  동일한 값이 중복처리
    DENSE RANK()    1 2 3 3 4 5   1 2 3 3 3 5
    ROW_NUMBER()    1 2 3 4 5 6     순서대로
    ROWNUM          1 2 3 4 5 6     순서대로
    
    BBS -> 계시판  최신글 위로 올릴때
*/

SELECT employee_id, first_name
FROM employees
WHERE employee_id >= 100 AND employee_id <= 109;

--OVER()  -- 값을 보고싶을떄
-- select 절에서만 사용
-- GROUP BY 를 보강하기 위해서 작성된 함수
SELECT department_id, COUNT(*)OVER()
FROM employees;

SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_name, COUNT(*)OVER(PARTITION BY department_id)
FROM departments;

SELECT first_name, 
        RANK()OVER(ORDER BY salary desc) as RAMK,
        DENSE_RANK()OVER(ORDER BY salary desc) as danseRAMK,
        ROW_NUMBER() OVER(ORDER BY salary desc) as rowRAMK
FROM employees;
SELECT first_name, RANK()OVER(ORDER BY salary ASC)
FROM employees;

-- ROWNUM
SELECT ROWNUM, employee_id, first_name
FROM employees
WHERE ROWNUM <= 10;

SELECT ROWNUM, employee_id, first_name --2
FROM employees
WHERE ROWNUM > 10 or ROWNUM < 20; --1 안된다
-- 1, 순위를 설정
-- 2. 번호를 할당
-- 3. 범위를 설정
SELECT rnum, employee_id, first_name, salary
FROM (SELECT ROWNUM as rnum, employee_id, first_name, salary  --2
    FROM (  SELECT employee_id, first_name, salary
            FROM employees
            ORDER BY salary DESC) )
WHERE rnum >= 11 AND rnum <= 20;

--문제13) 최근 입사한 사원 순으로 작성해서 1 ~ 10번째, 11 ~ 20 사원의 정보
--를 출력하시오
SELECT rnum, hire_date, job_id, last_name
FROM(
    SELECT ROWNUM as rnum, hire_date, job_id, last_name
        FROM (
            (SELECT hire_date, job_id, last_name
            FROM employees
            ORDER BY hire_date desc)
        )
        )
        where rnum < 20;
        
