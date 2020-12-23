-- 문제1) EMPLOYEES 테이블에서 (Kochhar의 급여)보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하라.
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > (SELECT salary 
                FROM employees 
                WHERE last_name = 'Kochhar');
                
-- 문제2) EMPLOYEES 테이블에서 (급여의 평균)보다 적은 사원의 정보를 사원번호,이름,담당업무,급여,부서번호를 출력하여라.  
SELECT employee_id, first_name, job_id, department_id, salary
FROM employees
WHERE salary < (SELECT AVG(salary) 
                FROM employees);

-- 문제3) EMPLOYEES 테이블에서 (100번 부서의 최소 급여)보다 최소 급여가 많은 다른 모든 부서를 출력하라
-- 그룹함수 -> 통계
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (  SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = 100);

-- 문제4) (업무별로 최소 급여)를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하여라. 
-- 단 업무별로 정렬하여라.
SELECT employee_id, first_name, job_id, department_id, salary
FROM employees
WHERE (job_id, salary) IN(  SELECT job_id, MIN(salary) 
                            FROM employees 
                            GROUP BY job_id);

-- 문제5) EMPLOYEES 과 DEPARTMENTS 테이블에서 업무가 SA_MAN 사원의 정보를 이름,업무,부서명,근무지를 출력하라.
-- from절
SELECT e.first_name, e.job_id, d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND e.job_id = 'SA_MAN';

SELECT e.first_name, e.job_id, d.department_name, d.location_id
FROM (  SELECT first_name, job_id, department_id
        FROM employees
        WHERE job_id = 'SA_MAN' ) e, departments d
WHERE e.department_id = d.department_id;

-- 문제6) EMPLOYEES 테이블에서 (가장 많은 사원의 수)을 갖는 MANAGER의 사원번호를 출력하라.
SELECT manager_id, COUNT(*)
FROM employees
GROUP BY manager_id
HAVING COUNT(manager_id) = (SELECT MAX( COUNT(*) )
                            FROM employees
                            GROUP BY manager_id);


-- 문제7) EMPLOYEES 테이블에서 (가장 많은 사원수)이 속해 있는 부서 번호와 사원수를  출력하라.
SELECT department_id, COUNT(department_id)
FROM employees
GROUP BY department_id
HAVING COUNT(department_id) = ( SELECT MAX(COUNT(*))
                                FROM employees
                                GROUP BY department_id);

-- 문제8) EMPLOYEES 테이블에서 (사원번호가 123인 사원의 직업)과 같고 (사원번호가 192인 사원의 급여(SAL))보다 많은 사원의 
-- 사원번호,이름,직업,급여를 출력하라.
SELECT employee_id, first_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 123)   -- 사원번호가 123인 사원의 직업 ST_MAN
    AND salary > (SELECT salary FROM employees WHERE employee_id = 192); -- 사원번호가 192인 사원의 급여(SAL) 4000


-- 문제9)(직업(JOB)별로 최소급여)를 받는 사원의 정보를 사원번호,이름,업무,부서명을 출력하라.
-- 조건1 :직업별로 내림차순정렬
SELECT employee_id, last_name, job_id, salary, d.department_name
FROM employees e, departments d
WHERE (job_id, salary)IN(  SELECT job_id, MIN(salary)
                            FROM employees
                            GROUP BY job_id )
    AND e.department_id = d.department_id
ORDER BY salary DESC;

-- 문제10) EMPLOYEES 테이블에서 업무별로 최소 급여와 같은 급여를 받는 사원의 정보를 사원번호,이름,업무,입사일자,급여,부서번호를 출력하라
SELECT employee_id, last_name, job_id, salary, d.department_name
FROM employees e, departments d
WHERE salary IN(  SELECT MIN(salary)
                            FROM employees
                            GROUP BY job_id )
    AND e.department_id = d.department_id;


-- 문제10) EMPLOYEES 테이블에서 (50번 부서의 최소 급여)를 받는 사원보다 많은 급여를 받는 사원의 정보를 
-- 사원번호,이름,업무,입사일자,급여,부서번호를 출력하라. 
-- 단 50번은 제외
SELECT employee_id, first_name, job_id, hire_date, salary, department_id 
FROM employees
WHERE salary > (SELECT MIN(salary)
                FROM employees
                WHERE department_id = 50)
    AND department_id <> 50;

-- 문제11) EMPLOYEES 테이블에서 (50번 부서의 최고 급여)를 받는 사원 보다 많은 급여를 받는 사원의 정보를 
-- 사원번호,이름,업무,입사일자,급여,부서번호를 출력하라. 
-- 단50번은 제외

-- scott
-- 37)DECODE 또는 CASE WHEN THEN 함수를 사용하여 다음 데이터에 따라 JOB열의 값을 기준으로 모든 사원의 등급을 표시하시오.
/*
업무        등급
PRESIDENT   A
ANALYST     B
MANAGER     C
SALESMAN    D
CLERK       E
기타         0
*/
SELECT ename, job,
    DECODE(job,
        'PRESIDENT', 'A',
        'ANALYST', 'B',
        'MANAGER', 'C',
        'SALESMAN', 'D',
        'CLERK', 'E',
        0 ) as Grade    
FROM emp;

SELECT ename, job,
    CASE job
        WHEN 'PRESIDENT' THEN 'A'
        WHEN 'ANALYST' THEN 'B'
        WHEN 'MANAGER' THEN 'C'
        WHEN 'SALESMAN' THEN 'D'
        WHEN 'CLERK' THEN 'E'
        ELSE '0'
    END as Grade
FROM emp;

-- 60) (BLAKE와 같은 부서)에 있는 사원들의 이름과 입사일을 구하는데 BLAKE는 제외하고 출력하시오.(BLAKE가 여러명일 수 있음)

SELECT ename, hiredate
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename = 'BLAKE')
    AND ename != 'BLAKE';

-- 61) 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을 출력하는데 
-- 월급이 높은 사람순으로 출력하시오.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal) FROM emp)
ORDER BY sal DESC;

-- 62) (10번부서에서 급여를 가장 적게 받는 사원)과 동일한 급여를 받는 사원의 이름을 출력하시오.
SELECT ename, sal
FROM emp
WHERE sal = (   SELECT MIN(sal)
                FROM emp
                WHERE deptno = 10 );

-- 63) 사원수가 3명이 넘는 부서의 부서명과 사원수를 출력하시오.
SELECT d.dname, COUNT(e.empno)
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) > 3;

-- 64) 사원번호가 7844인 사원보다 빨리 입사한 사원의 이름과 입사일을 출력하시오.
SELECT ename, hiredate
FROM emp
WHERE hiredate < (  SELECT hiredate
                    FROM emp
                    WHERE empno = 7844 );

-- 65) 직속상사(mgr)가 KING인 모든 사원의 이름과 급여를 출력하시오.
SELECT ename, sal, mgr
FROM emp
WHERE mgr = (SELECT empno
             FROM emp
             WHERE ename = 'KING');

-- 66) (20번 부서에서 가장 급여)를 많이 받는 사원과 동일한 급여를 받는 
-- 사원의 이름과 부서명,급여,급여등급을 출력하시오.(emp, dept, salgrade(비교테이블))

SELECT e.ename, d.dname, sal, s.grade
FROM emp e, dept d, salgrade s
WHERE sal = (SELECT MAX(sal)
             FROM emp
             WHERE deptno = 20)
    AND e.deptno = d.deptno
    AND sal BETWEEN s.losal AND s.hisal;

--67) 총급여(sal+comm)가 (평균 급여)보다 많은 급여를 받는 사람의 
-- 부서번호, 이름, 총급여, 커미션을 출력하시오.(커미션은 유(O),무(X)로 표시하고 컬럼명은 "comm유무" 출력)
SELECT deptno, ename, sal + NVL(comm, 0), NVL(comm, 0), NVL2(comm, '있음', '없음')
FROM emp                                            --  (comm != null) ? "있음":"없음"
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal) FROM emp);

-- 68) CHICAGO 지역에서 근무하는 사원의 평균 급여보다 높은 급여를 받는 사원의 
-- 이름과 급여, 지역명을 출력하시오.
-- 1.지역에 따른 부서번호
-- 2.평균급여
-- 3.비교

SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE sal > (   SELECT AVG(sal)
                FROM emp
                WHERE deptno = (SELECT deptno
                                FROM dept
                                WHERE loc = 'CHICAGO')
            )
    AND e.deptno = d.deptno;

-- 69) 업무가 SALESMAN인 직원이 2명 이상인 부서의 이름, 근무하는 사원의 이름, 업무를 출력하시오.(컬럼명은 부서명, 사원명, 업무로 출력)
SELECT d.dname 부서명, e.ename 사원명, e.job 업무
FROM emp e, dept d
WHERE e.deptno = d.deptno
    AND d.deptno IN(  SELECT deptno
                    FROM emp
                    WHERE job = 'SALESMAN'
                    GROUP BY deptno
                    HAVING COUNT(job) >= 2); 

-- 70) 커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급을 출력하시오.

SELECT e.ename, s.grade
FROM emp e, salgrade s
WHERE sal = (SELECT MAX(sal)
            FROM emp
            WHERE comm IS NULL or comm = 0)
    AND sal BETWEEN s.losal AND s.hisal;

-- 71) (SMITH의 관리자(mgr))의 이름과 부서명, 근무지역을 출력하시오. 
SELECT e.ename, d.dname, d.loc
FROM emp e, dept d
WHERE e.empno = (   SELECT mgr
                    FROM emp
                    WHERE ename = 'SMITH')
    AND e.deptno = d.deptno;












