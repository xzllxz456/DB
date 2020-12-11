/*
    Join : 두개 이상의 테이블을 연결해서 데이터를 취득
    
    inner Join
    full outer Join
    cross Join
    outer Join
        left Join
        right Join
    self Join : 같은 테이블에 정보취득
*/

SELECT e.first_name, d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
    and e.job_id = j.job_id
        and e.first_name = 'Lex';
        
SELECT emp.first_name as "직원명",mag.first_name as "상사명"
FROM employees emp, employees mag
WHERE emp.manager_id = mag.manager_id;

--문제1) EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian
--Product(모든 가능한 행들의 Join)하여 사원번호,이름,업무,부서번호,부서명, 근무지를 출력하여라. 
--cross
SELECT e.employee_id, e.first_name, e.job_id, e.department_id,
        d.department_id, d.department_name,d.location_id
FROM employees e CROSS JOIN departments d;

--문제2) EMPLOYEES 테이블에서 사원번호,이름,업무, EMPLOYEES 테이블의
--부서번호, DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라.
SELECT e.employee_id, e.first_name, e.job_id,
e.department_id, d.department_id, d.department_name,d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, e.first_name, e.job_id,
e.department_id, d.department_id, d.department_name,d.location_id
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id;
    
-- 문제3) Alexander Hunold 의 부서명을 출력하라.
SELECT e.first_name, d.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    and e.first_name = 'Alexander'
    and e.last_name = 'Hunold';
    
--문제4) 세일즈 부서에서 근무하고 있는 사람들을 출력하라.
SELECT d.department_name, e.first_name, e.last_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
    and d.department_name = 'Sales';
    
 --   문제5) EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고
--SA_MAN 사원만의 사원번호,이름,급여,부서명,근무지를 출력하라.
--(Alias를 사용)
SELECT e.employee_id, e.first_name, e.salary,
d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
 and e.job_id = 'SA_MAN';
 
--문제6) EMPLOYEES 테이블과 DEPARTMENTS 테이블에서 DEPARTMENTS 테
--이블에 있는 모든 자료를 사원번호,이름,업무, EMPLOYEES 테이블의 부서번
--호, DEPARTMENTS 테이블의 부서번호,부서명,근무지를 출력하여라
--(Outer Join)

SELECT e.department_id, e.first_name, e.job_id,
    d.department_name, d.location_id
FROM departments d, employees e
WHERE d.department_id = e.department_id(+)
UNION
SELECT e.department_id, e.first_name, e.job_id,
    d.department_name, d.location_id
FROM departments d, employees e
WHERE d.department_id(+) = e.department_id;

SELECT e.department_id, e.first_name, e.job_id,
    d.department_name, d.location_id
FROM departments d full outer join employees e
on d.department_id = e.department_id;

-- 문제7) EMPLOYEES 테이블에서 Self join하여 관리자(매니저)를 출력하여라.
SELECT concat( e.first_name , '의 상사는'), concat( m.first_name, '입니다')
FROM employees e, employees m
WHERE e.manager_id = m.employee_id;

--문제8) EMPLOYEES 테이블에서 left join하여 관리자(매니저)를 출력하고
--매니저 아이디가 없는 사람은 배제하고 하향식으로 하며, 급여는 역순으로 출력하라.
SELECT e.employee_id, e.first_name, e.manager_id, m.employee_id,
m.first_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id(+)
--    and e.manager_id is not null
start with e.manager_id is not null
CONNECT by e.manager_id = PRIOR e.employee_id
ORDER by e.salary DESC;
--문제9) EMPLOYEES 테이블에서 right join하여 관리자(매니저)가 108번
--상향식으로 급여는 역순으로 출력하라.
SELECT e.employee_id, e.first_name, e.salary,
    e.manager_id, m.employee_id, m.first_name
FROM employees e, employees m
WHERE e.manager_id(+) = m.employee_id
    and e.manager_id = '108'
CONNECT BY prior e.manager_id = e.employee_id
ORDER by e.salary DESC;


