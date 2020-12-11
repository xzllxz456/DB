/*
    SUB Query
    Query 안에 Query
    
    SELECT   단일 ROW 단일 COLUM
    FROM     다중 ROW 다중 COLUM
    WHERE    다중 ROW 다중 COLUM
*/

-- SELECT
 SELECT employee_id, first_name,
 (SELECT first_name  FROM  employees WHERE employee_id = 100)
 FROM employees;
 -- COLUM 2개 , ROW 5개
  SELECT employee_id, first_name,
-- (SELECT first_name, last_name  FROM  employees WHERE job_id = 'IT_PROG') 여러개라 오류남
-- (SELECT first_name, last_name  FROM  employees WHERE employee_id = 100) 여러개라 오류남
(SELECT COUNT(*) FROM  employees)
 FROM employees;
 
-- FROM 넘겨주는 데이터를 다 받아줘야 한다.
SELECT employee_iD, first_name, salary
FROM (SELECT employee_id, first_name, salary FROM employees);

SELECT EMPNO, first_name, salary
FROM (SELECT employee_id AS "EMPNO", first_name, salary
        FROM employees
        WHERE job_id = 'IT_PROG')
WHERE salary > 5000;
-- 부서번호 50번 급여가 6000이상인 사원
SELECT
    *
FROM employees
WHERE department_id = 50 AND salary > 6000;

SELECT
    *
FROM (SELECT * FROM employees 
        WHERE department_id = 50)
WHERE salary > 6000;

-- 급여의 합계, 인원수, 사원명, 월급
/*
SELECT job_id, COUNT(*) -- 사원명 불가
FROM employees
GROUP BY job_id;
*/
SELECT e.first_name, e.salary, e.job_id, 
        j.job_id, j.salsum as "급여 합계", j."합계" as "합"
FROM employees e, (SELECT job_id, SUM(salary) as salsum, COUNT(*) as "합계"
                        FROM employees
                        GROUP BY job_id) j
WHERE e.job_id = j.job_id;

-- where
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) from employees);

-- department_id = 90의 job_id
SELECT job_id, first_name, department_id
FROM employees
WHERE job_id in(SELECT job_id from employees where department_id = 90);

-- 부서별로 가장 월급을 적게 받는 사원과 같은 급여를 받는 사원
SELECT first_name, salary, department_id
FROM employees
WHERE salary in(SELECT MIN(salary) FROM employees
                GROUP BY department_id);
-- 부서별로 가장 월급을 적게 받는 사원명과 월급
/*
SELECT department_id, MIN(salary), first_name -- 오류남
FROM employees
GROUP BY department_id;
*/
SELECT department_id, first_name,salary
FROM employees
WHERE (department_id, salary)  
        IN(SELECT  department_id , MIN(salary) FROM employees GROUP by department_id);
        
-- 문제1) EMPLOYEES 테이블에서 Kochhar의 급여보다 많은 사원의 정보를 사원
-- 번호,이름,담당업무,급여를 출력하라.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > (SELECT salary FROM employees
                    WHERE last_name = 'Kochhar');
--문제2) EMPLOYEES 테이블에서 급여의 평균보다 적은 사원의 정보를 사원번호,
--이름,담당업무,급여,부서번호를 출력하여라.
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE salary < (SELECT TRUNC(AVG(salary)) FROM employees );

--문제3) EMPLOYEES 테이블에서 100번 부서의 최소 급여보다 최소 급여가
--많은 다른 모든 부서를 출력하라
SELECT department_id, MIN(SALARY)
FROM employees 
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary) FROM employees 
                        WHERE department_id = '100'
                        GROUP BY department_id);

--문제4) 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호
--를 출력하여라. 단 업무별로 정렬하여라.
SELECT employee_id, last_name,salary, job_id, department_id
FROM employees 
where (job_id, salary) IN (SELECT job_id, MIN(salary) FROM employees
                        GROUP BY job_id)
ORDER BY job_id asc;

--문제5) EMPLOYEES 과 DEPARTMENTS 테이블에서 업무가 세일드맨 사원의 정
--보를 이름,업무,부서명,근무지를 출력하라.
SELECT e.last_name, e.job_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id 
    AND d.department_name IN(SELECT department_name FROM departments WHERE department_name = 'Sales');
    
SELECT e.first_name, e.job_id, d.department_name, d.location_id
FROM(SELECT first_name, job_id, department_id
FROM employees 
where job_id = 'SA_MAN') e, departments d
WHERE e.department_id = d.department_id;
    
--문제6) EMPLOYEES 테이블에서 가장 많은 사원을 갖는 MANAGER의
--사원번호를 출력하라.
SELECT manager_id
FROM employees 
GROUP BY manager_id
HAVING COUNT(*) IN(SELECT MAX(COUNT(manager_id)) FROM employees GROUP BY manager_id);

SELECT manager_id
FROM (SELECT manager_id,COUNT(*) EMP_COUNT
        FROM employees
            GROUP BY manager_id)
WHERE EMP_COUNT = (SELECT MAX(COUNT(*))
                    from employees
                            GROUP BY MAnager_id);
SELECT A.MANAGER_ID
from (SELECT manager_id,COUNT(*) EMP_COUNT
        FROM employees
            GROUP BY manager_id) a
            INNER JOIN
(SELECT MAX(COUNT(*)) MAX_COUNT
                    from employees
                            GROUP BY MAnager_id) M
                on a.emp_count = m.max_count;
                
-- rownum
SELECT MANAGER_ID FROM(
SELECT manager_id, COUNT(*) EMP_COUNT
FROM employees
GROUP BY manager_id
ORDER BY EMP_COUNT desc)
WHERE ROWNUM = 1;

SELECT manager_id
from (SELECT ROW_NUMBER() OVER (ORDER BY COUNT(*) desc) row_count, manager_id, count(*)
    FROM employees
    GROUP by manager_id)
WHERE row_count = 1;/
--문제7) EMPLOYEES 테이블에서 가장 많은 사원이 속해있는
--부서번호와 사원수를 출력하라.

SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) IN (SELECT MAX(COUNT(employee_id)) FROM employees GROUP BY department_id);

--문제8) EMPLOYEES 테이블에서 사원번호가 123인 사원의 직업과 같고
--사원번호가 192인 사원의 급여(SAL)보다 많은 사원의 사원번호, 이름,
--직업, 급여를 출력하라.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id 
FROM employees WHERE employee_id = 123) 
and salary > (SELECT salary FROM employees 
                                    WHERE employee_id = 192);
                                    
--문제9) 직업(JOB)별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업
--무, 부서명을 출력하라.
-- 조건1 : 직업별로 내림차순 정렬
SELECT e.employee_id, e.last_name, e.job_id,
        d.department_name
FROM employees e INNER JOIN departments d
    on e.department_id = d.department_id
where (e.job_id, e.salary) 
IN(SELECT job_id, MIN(salary)
FROM employees GROUP BY job_id )
ORDER BY e.job_id DESC;

--문제10) EMPLOYEES 테이블에서 업무별로 최소 급여와 같은 급여를 받는 사원의 정보를 사
--원번호,이름,업무,입사일자,급여,부서번호를 출력하라
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
where salary IN(SELECT  MIN(salary)
FROM employees 
GROUP BY job_id);

--문제11) EMPLOYEES 테이블에서 50번 부서의 최소 급여를 받는 사원 보다 많
--은 급여를 받는 사원의 정보를 사원번호,이름,업무,입사일자,급여,부서번호를
--출력하라. 단 50번은 제외
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE salary > (SELECT MIN(salary) FROM employees WHERE
                department_id = 50) and department_id <> 50;
                
--문제12) EMPLOYEES 테이블에서 50번 부서의 최고 급여를 받는 사원 보다
--많은 급여를 받는 사원의 정보를 사원번호,이름,업무,입사일자,급여,부서번호를
--출력하라. 단50번은 제외
SELECT employee_id, last_name, job_id, hire_date, salary, department_id
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE
                department_id = 50
                GROUP BY department_id) and department_id <> 50;
--문제13) 최근 입사한 사원 순으로 작성해서 1 ~ 10번째, 11 ~ 20 사원의 정보
--를 출력하시오
SELECT ROWNUM, hire_date, job_id, last_name
FROM (
        SELECT hire_date, job_id, last_name
        FROM employees
        ORDER BY hire_date desc)
WHERE ROWNUM BETWEEN 1 AND 20;