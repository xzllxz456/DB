/*
    SELECT 절 : COLUMN명, ALIAS, FUNCTION, SUBQUERY(QUERY문안에 QUERY)
    FROM 절 : TABLE, SUBQUERY

-- WHERE
    표현식
    비교연산자(=, >, <, !=, >=, <=, <>)
    NULL, = NULL(틀린문법) IS NULL(맞는문법), IS NOT NULL
    ( ), NOT, AND(&&), OR(||)       if a > 7 && b < 4
*/

-- FIRST_NAME == Julia
SELECT first_name, LAST_name, salary
FROM employees
WHERE first_name ='Julia';

-- 월급이 $9000이상인 사원

SELECT first_name, salary 
FROM employees
WHERE salary >= 9000;

-- 이름이 shanta 보다 큰이름
SELECT first_name
FROM employees
WHERE first_name > 'Shanta';

SELECT first_name
FROM employees
WHERE first_name >= 'a'; -- 안나옴 'a'는 97

SELECT first_name
FROM employees
WHERE first_name >= 'A';

SELECT first_name, manager_id
FROM employees
WHERE manager_id = ''; -- ''는 null X        String = "" != String = null;

SELECT first_name, manager_id
FROM employees
WHERE manager_id IS NULL;

SELECT first_name, manager_id
FROM employees
WHERE manager_id IS NOT NULL;

-- AND

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Shanta'
    AND first_name = 'John';
    
SELECT first_name, last_name, salary
FROM employees
WHERE first_name = 'Shanta'    OR first_name = 'John';
-- 이름 John, 월급이 5000이상    
SELECT first_name, salary
FROM employees
WHERE first_name = 'John'
    AND salary >= 5000;

-- 2007년 12월 31일 이후에 입사한 사원의 정보
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '07/12/31';
-- WHERE hire_date > '07/12/31';
SELECT first_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('071231', 'YYMMDD');

-- ALL(AND), ANY(OR)
SELECT first_name
FROM employees
WHERE first_name = ALL('Julia', 'John');
SELECT first_name
FROM employees
WHERE first_name = ALL('John');
SELECT first_name
FROM employees
WHERE first_name = ALL('Julia');

SELECT first_name
FROM employees
WHERE first_name = ANY('Julia', 'John');
--WHERE first_name = 'Shanta'    OR first_name = 'John';

-- IN, NOT IN

SELECT first_name, salary
FROM employees
WHERE salary IN(8000, 3200, 6000);
--WHERE first_name = 'Shanta'    OR first_name = 'John';

SELECT first_name, salary
FROM employees
WHERE salary NOT IN(8000, 3200, 6000);

SELECT first_name, salary
FROM employees
WHERE first_name IN('Julia', 'John');

-- BETWEEN 범위 연산자
/*
    SALARY >= 3200 AND SALATY <= 9000
    SALARY BETWEEN 3200 AND 9000
*/

SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 3200 AND 9000; -- SALARY >= 3200AND SALARY <= 9000

SELECT first_name, salary
FROM employees
WHERE salary NOT BETWEEN 3200 AND 9000; -- SALARY < 3200AND SALARY > 9000

-- LIKE 중요함
SELECT first_name
FROM employees
WHERE first_name LIKE 'G_ra_d';  -- _한문자

SELECT first_name
FROM employees
WHERE first_name LIKE 'Al%';  -- % 글자수 제한 X

SELECT first_name
FROM employees
WHERE first_name LIKE '%Al%';   -- 글자 사이에 Al

SELECT first_name
FROM employees
WHERE first_name LIKE 'K%y';   -- 앞이 K____뒤가 y

SELECT first_name
FROM employees
WHERE first_name LIKE '%y'; -- 맨 뒤가 y

-- 2006년도에 입사한 사람
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '06/01/01' AND hire_date < '07/01/01';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '06%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '06/01%';

