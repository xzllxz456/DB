-- ORDER BY = SORTING
/*
    DB -> Sorting -> Java   �̰� �� ������ ����
    DB -> Java -> Sorting

    SELECT * FROM TABLE
    ORDER BY sal ASC    --����
     ORDER BY DESC      --����
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

-- �� ��¥���� ����(������)
SELECT MONTHS_BETWEEN(SYSDATE, '2021-04-13')
FROM dual;
SELECT MONTHS_BETWEEN('2021-04-13', SYSDATE)
FROM dual;
SELECT MONTHS_BETWEEN('2021-04-13', '2020-11-10')
FROM dual;

-- Ư�� ��¥ ���� ������ ���� ���� �ش� ��¥�� ��ȯ
SELECT ADD_MONTHS('2020-12-01', 6)
FROM DUAL;

-- ��¥ ���� ����, ��, ��, ��, ��, ��
SELECT EXTRACT(YEAR FROM TO_DATE('201202', 'YYmmdd')) AS ����,
    EXTRACT(month FROM TO_DATE('20-12-02', 'YY-mm-dd')) AS ��
FROM DUAL;

SELECT EXTRACT(YEAR FROM SYSDATE) AS ����,
    EXTRACT(month FROM SYSDATE) AS ��,
    EXTRACT(day FROM SYSDATE) AS ��,
    EXTRACT(HOUR FROM CAST(SYSDATE AS TIMESTAMP)) AS ��,
    EXTRACT(MINUTE FROM CAST(SYSDATE AS TIMESTAMP)) AS ��,
    EXTRACT(SECOND FROM CAST(SYSDATE AS TIMESTAMP)) AS ��
FROM DUAL;

