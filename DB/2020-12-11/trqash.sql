SELECT e.ename, e.sal, d.loc
FROM emp e , (SELECT loc, deptno
                FROM dept) d
WHERE d.deptno = e.deptno
    AND e.sal > (SELECT avg(e.sal)
                FROM emp e, dept d
                where d.loc = 'CHICAGO') AND d.loc != 'CHICAGO';