--7)DECODE 또는 CASE WHEN THEN 함수를 사용하여 다음 데이터에 따라 JOB열의 값을 기준으로
--모든 사원의 등급을 표시하시오.
--업무        등급
--PRESIDENT   A
--ANALYST     B
--MANAGER     C
--SALESMAN    D
--CLERK       E
--기타         0
SELECT job,
    CASE job 
        WHEN 'PRESIDENT' THEN 'A'
        WHEN 'ANALYST' THEN 'B'
        WHEN 'MANAGER' THEN 'C'
        WHEN 'SALESMAN' THEN 'D'
        WHEN 'CLERK' THEN 'E'
        ELSE '0'
    END AS "등급"
FROM emp;

SELECT ename, job,
    decode(  job,  'PRESIDENT' , 'A',
         'ANALYST' , 'B',
         'MANAGER' , 'C',
         'SALESMAN' , 'D',
         'CLERK' , 'E',
         '0') as GRADE
FROM emp;

-- 60) BLAKE와 같은 부서에 있는 사원들의 이름과 입사일을 구하는데 
-- BLAKE는 제외하고 출력하시오.(BLAKE가 여러명일 수 있음)
SELECT ename, hiredate
FROM emp
WHERE job IN(SELECT job
FROM emp WHERE ename = 'BLAKE' GROUP BY job) AND ename <> 'BLAKE';
-- 61) 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을 출력하는데 
-- 월급이 높은 사람순으로 출력하시오.
SELECT empno, ename, sal
FROM emp
WHERE sal > (SELECT trunc(AVG(sal)) FROM emp)
ORDER BY sal DESC;
-- 62) 10번부서에서 급여를 가장 적게 받는 사원과 동일한 급여를 받는 사원의 이름을 출력하시오.
SELECT ename, sal, deptno
FROM emp
WHERE sal IN(SELECT MIN(sal) FROM emp WHERE deptno = 10); 

-- 63) 사원수가 3명이 넘는 부서의 부서명과 사원수를 출력하시오.

SELECT d.dname, e.cnt
FROM dept d, (SELECT deptno,count(empno) as cnt 
                FROM emp GROUP BY deptno)e
WHERE d.deptno = e.deptno 
    AND e.cnt>=3; -- 방법1)
    
SELECT d.dname,COUNT(e.empno) cnt 
FROM emp e, dept d 
WHERE e.deptno = d.deptno 
GROUP BY d.dname 
HAVING COUNT(e.empno)>3; --방법2)

-- 64) 사원번호가 7844인 사원보다 빨리 입사한 사원의 이름과 입사일을 출력하시오.
SELECT ename, hiredate
FROM emp
WHERE hiredate < (SELECT hiredate 
                    FROM emp
  WHERE empno = 7844);

-- 65) 직속상사가 KING인 모든 사원의 이름과 급여를 출력하시오.
SELECT ename, sal
FROM emp
WHERE mgr = (SELECT empno
FROM emp 
WHERE ename = 'KING');
-- 66) 20번 부서에서 가장 급여를 많이 받는 사원과 동일한 급여를 받는 
-- 사원의 이름과 부서명,급여, 급여등급을 출력하시오.(emp, dept, salgrade)
SELECT e.ename, e.deptno, d.dname, e.sal, s.grade
FROM emp e INNER JOIN dept d ON e.deptno = d.deptno 
            INNER JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE e.sal = (SELECT MAX(sal)
FROM emp 
WHERE deptno = 20);

SELECT e.ename, e.deptno, d.dname, e.sal, s.grade
FROM emp e, dept d, salgrade s
WHERE sal = (SELECT MAX(sal) from emp where deptno = 20)
    and e.deptno = d.deptno
        ANd sal BETWEEN s.losal AND s.hisal;
--67) 총급여sal+comm가 평균 급여보다 많은 급여를 받는 사람의 부서번호, 이름, 총급여, 
--    커미션을 출력하시오.(커미션은 유(O),무(X)로 표시하고 컬럼명은 "comm유무" 출력)
SELECT deptno, ename, sal+NVL(comm,0),NVL(comm,0),NVL2(comm , '유', '무')
FROM emp
WHERE sal + NVL(comm, 0) > (SELECT AVG(sal)
FROM emp);

SELECT deptno,ename,sal+nvl(comm,0) 총급여 ,
    CASE 
    WHEN comm IS NOT NULL then 'o' 
    ELSE 'x'
    END AS "comm유무" FROM emp 
    WHERE sal+NVL(comm,0) >(SELECT avg(sal) FROM emp);

-- 68) CHICAGO 지역에서 근무하는 사원의 평균 급여보다 높은 급여를 받는 사원의 이름과 급여,
--    지역명을 출력하시오.
SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
    AND e.sal > (SELECT AVG(e.sal)
                    FROM emp e, dept d WHERE e.deptno = d.deptno 
                        AND d.loc = 'CHICAGO');

SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE sal >
(SELECT AVG(sal)
FROM emp 
where deptno = (SELECT deptno
FROM dept 
WHERE loc = 'CHICAGO')
) and e.deptno = d.deptno;


-- 69) 업무가 SALESMAN인 직원이 2명 이상인 부서의 이름, 근무하는 사원의 이름, 업무를 출력
--    하시오.(컬럼명은 부서명, 사원명, 업무로 출력)
SELECT d.dname as "부서명", e.ename as "사원명", e.job as "업무"
FROM emp e, dept d
WHERE e.deptno = d.deptno
    AND e.deptno IN (SELECT deptno FROM emp 
                    GROUP BY deptno
                    HAVING COUNT(job) >= 2)
                    AND job = 'SALESMAN' ;
                    

SELECT d.dname as "부서명", e.ename as "사원명", e.job as "업무"
FROM emp e, dept d      
WHERE e.deptno = d.deptno
    AND e.job = 'SALESMAN'
   AND d.dname = (SELECT d.dname FROM emp e, dept d
    where e.deptno = d.deptno
        and e.job = 'SALESMAN'
        GROUP BY d.dname
        HAVING COUNT(e.empno) > 2);
-- 70) 커미션이 없는 사원들 중 월급이 가장 높은 사원의 이름과 급여등급을 출력하시오.
SELECT e.ename,e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal and s.hisal
    AND e.sal = (SELECT MAX(sal)
    FROM emp
    where comm IS NULL);

-- 71) SMITH의 관리자의 이름과 부서명, 근무지역을 출력하시오. 
SELECT e.ename, d.dname, d.loc
FROM emp e ,dept d
WHERE e.deptno = d.deptno
    AND e.empno  = (SELECT mgr
    FROM emp where ename = 'SMITH');
    