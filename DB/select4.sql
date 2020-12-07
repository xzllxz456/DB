-- ORDER BY = SORTING
/*
    DB -> Sorting -> Java   이게 더 성능이 빠름
    DB -> Java -> Sorting

    SELECT * FROM TABLE
    ORDER BY sal ASC    --오름
     ORDER BY DESC      --내림
*/

SELECT ename, sal
FROM emp
ORDER BY sal ASC;

SELECT ename, sal
FROM emp
ORDER BY sal DESC;

-- alias
SELECT empno, ename, (sal * 12)AS annsal
FROM emp
ORDER BY sal DESC;

SELECT ename, comm
FROM emp
ORDER BY COMM NULLS FIRST;
SELECT ename, comm
FROM emp
ORDER BY COMM NULLS LAST;

SELECT ename, job, sal
FROM emp
ORDER BY job asc, sal DESC;

-- 두 날짜간의 월수(월간격)
SELECT MONTHS_BETWEEN(SYSDATE, '2021-04-13')
FROM dual;
SELECT MONTHS_BETWEEN('2021-04-13', SYSDATE)
FROM dual;
SELECT MONTHS_BETWEEN('2021-04-13', '2020-11-10')
FROM dual;

-- 특정 날짜 월에 정수를 더한 다음 해당 날짜를 반환
SELECT ADD_MONTHS('2020-12-01', 6)
FROM DUAL;

-- 날짜 정보 연도, 월, 일, 시, 분, 초
SELECT EXTRACT(YEAR FROM TO_DATE('201202', 'YYmmdd')) AS 연도,
    EXTRACT(month FROM TO_DATE('20-12-02', 'YY-mm-dd')) AS 월
FROM DUAL;

SELECT EXTRACT(YEAR FROM SYSDATE) AS 연도,
    EXTRACT(month FROM SYSDATE) AS 월,
    EXTRACT(day FROM SYSDATE) AS 일,
    EXTRACT(HOUR FROM CAST(SYSDATE AS TIMESTAMP)) AS 시,
    EXTRACT(MINUTE FROM CAST(SYSDATE AS TIMESTAMP)) AS 분,
    EXTRACT(SECOND FROM CAST(SYSDATE AS TIMESTAMP)) AS 초
FROM DUAL;

