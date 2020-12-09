/*
    Join -- 다른 테이블의 정보를 가저오기위한
    두개 이상의 테이블을 연결해서 데이터를 검색하는 방법.
    보통 두개이상의 행(low)들의 공통된 값 primary key(기본키) Foreign Key(외래키)값을
    사용해서 연결
    
    primary Key(기본키) : 테이블에서 중복되지 않는 키
    Foreign Key(외래키) : 다른 테이블에 있는 키
    
    Ansi SQL 문법
    Oracle 문법
    
    inner Join : 비중 제일 중요  
    full outer Join
    cross Join
    outer
        left Join : 중요
        right Join : 중요
    self Join : 제일 중요
*/

-- inner Join -- 교집합
-- Ansi SQL
SELECT e.employee_id, first_name,  --한쪽에 있는건 명시안해도 오류안남
        d.department_id, e.department_id,
        d.department_name
FROM employees e INNER JOIN departments d 
    ON e.department_id = d.department_id;
--Oracle SQL
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- full outer Join -- 합집합
-- ansi
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e FULL OUTER JOIN departments d
    ON e.department_id = d.department_id;
-- cross Join 합집합
-- oracle
SELECT e.department_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e, departments d;

-- Outer Join -차집합
-- left, right
-- Ansi
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e LEFT OUTER JOIN departments d
   ON e.department_id = d.department_id;
   
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e RIGHT OUTER JOIN departments d
   ON e.department_id = d.department_id;
-- Oracle -- (+ 가있는거에서 없는 방향)
SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);
--                 <--   left join
--WHERE e.department_id(+) = d.department_id;  right join

SELECT e.employee_id, e.first_name,
        e.department_id, d.department_id,
        d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+)
        AND e.department_id IS NULL;
        
-- self Join : 동일한 테이블 Join
SELECT a.employee_id, a.first_name,
        a.manager_id, b.employee_id,
        b.first_name
FROM employees A, employees B -- A: 사원테이블 B: 상사테이블
WHERE A.manager_id = B.employee_id;

-- 계층형 구조 오름, 내림 정렬
SELECT a.employee_id, a.first_name,
        a.manager_id as "사원의 상사", b.employee_id,
        b.first_name as "상사의 이름"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)
--CONNECT BY PRIOR a.manager_id = a.employee_id; --상향식
CONNECT BY  a.manager_id = PRIOR a.employee_id; -- 하향식

-- 계층형 구조 오름, 내림
SELECT A.EMPLOYEE_ID, LPAD(' ', (LEVEL-1)*2) || A.FIRST_NAME, A.MANAGER_ID, B.EMPLOYEE_ID, B.FIRST_NAME
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID(+)
CONNECT BY  A.MANAGER_ID = PRIOR A.EMPLOYEE_ID; -- 상향식

SELECT COUNT(manager_id) FROM employees;
SELECT COUNT(*) FROM employees
WHERE manager_id IS NOT NULL;

-- 각 직원의 직업이름(줄임말 말고)과 부서번호, 부서명, 부서의 우편번호를 출력해보시오~
SELECT e.first_name || e.last_name as "이 름", 
        j.job_title, e.department_id, d.department_name, l.postal_code
FROM employees e, departments d, locations l, jobs j
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.job_id = j.job_id;

SELECT e.first_name || e.last_name as "이 름", 
        j.job_title, e.department_id, d.department_name, l.postal_code
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
        INNER JOIN locations l ON l.location_id = d.location_id
        INNER JOIN  jobs j ON j.job_id = e.job_id;
        
-- 문제1) EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian
-- Product(모든 가능한 행들의 Join)하여 사원번호,이름,업무,부서번호,부서명,
-- 근무지를 출력하여라.
SELECT e.employee_id, e.first_name|| ' ' || e.last_name, e.job_id,
e.department_id,d.department_name,d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, e.first_name|| ' ' || e.last_name, e.job_id,
e.department_id,d.department_name,d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;

-- 문제2) EMPLOYEES 테이블에서 사원번호,이름,업무, EMPLOYEES 테이블의
-- 부서번호, DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라.
SELECT e.employee_id, e.last_name, e.job_id, e.department_id, 
d.department_id, d.department_name, d.location_id

FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, e.last_name, e.job_id, e.department_id, 
d.department_id, d.department_name, d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;
    
--    문제3) Alexander Hunold 의 부서명을 출력하라.
SELECT e.first_name, e.last_name, e.department_id,
d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.first_name like 'Alexander'
    AND e.last_name like 'Hunold';

SELECT e.first_name, e.last_name, e.department_id,
d.department_id, d.department_name
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.first_name like 'Alexander'
    AND e.last_name like 'Hunold';
    
-- 문제4) 세일즈 부서에서 근무하고 있는 사람들을 출력하라.
SELECT e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND d.department_name like 'Sales';
    
SELECT e.first_name, d.department_id, d.department_name
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_name like 'Sales';

-- 문제5) EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고
-- SA_MAN 사원만의 사원번호,이름,급여,부서명,근무지를 출력하라.
-- (Alias를 사용)
SELECT e.employee_id, e.first_name||' '||e.last_name, e.salary,
d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.job_id like 'SA_MAN';
    
SELECT e.employee_id, e.first_name||' '||e.last_name, e.salary,
d.department_name, d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.job_id = 'SA_MAN';

-- 문제6) EMPLOYEES 테이블과 DEPARTMENTS 테이블에서 DEPARTMENTS 테
-- 이블에 있는 모든 자료를 사원번호,이름,업무, EMPLOYEES 테이블의 부서번
-- 호, DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라 (Outer Join)
SELECT e.employee_id, e.first_name||' '||e.last_name, e.job_id,
    e.department_id,
d.department_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id(+) = d.department_id;

SELECT e.employee_id, e.first_name||' '||e.last_name, e.job_id,
    e.department_id,
d.department_id, d.department_name, d.location_id
FROM employees e RIGHT OUTER JOIN departments d
    ON e.department_id = d.department_id;
    
-- 문제7) EMPLOYEES 테이블에서 Self join하여 관리자(매니저)를 출력하여라.

SELECT a.last_name|| ' 관리자는'|| b.last_name
FROM employees a, employees b
WHERE a.manager_id = b.employee_id;

SELECT a.last_name|| '의 관리자는' || b.last_name
FROM employees a INNER JOIN employees b
    ON a.manager_id = b.employee_id;
    
-- 문제8) EMPLOYEES 테이블에서 left join하여 관리자(매니저)를 출력하고
-- 매니저 아이디가 없는 사람은 배제하고 하향식으로 하며, 급여는 역순으로 출력하라.
SELECT a.employee_id ,a.first_name,
a.manager_id, b.employee_id, b.first_name
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)
START WITH a.manager_id IS NOT NULL
CONNECT BY  a.manager_id = PRIOR a.employee_id
ORDER BY a.salary DESC;

SELECT
    *
FROM employees a LEFT OUTER JOIN employees b
    ON a.manager_id = a.employee_id
START WITH a.manager_id IS NOT NULL
CONNECT BY  a.manager_id = PRIOR a.employee_id
ORDER BY a.salary DESC;