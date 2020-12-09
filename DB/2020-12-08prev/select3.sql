/*
    SELECT �� : COLUMN��, ALIAS, FUNCTION, SUBQUERY(QUERY���ȿ� QUERY)
    FROM �� : TABLE, SUBQUERY

-- WHERE
    ǥ����
    �񱳿�����(=, >, <, !=, >=, <=, <>)
    NULL, = NULL(Ʋ������) IS NULL(�´¹���), IS NOT NULL
    ( ), NOT, AND(&&), OR(||)       if a > 7 && b < 4
*/

-- FIRST_NAME == Julia
SELECT first_name, LAST_name, salary
FROM employees
WHERE first_name ='Julia';

-- ������ $9000�̻��� ���

SELECT first_name, salary 
FROM employees
WHERE salary >= 9000;

-- �̸��� shanta ���� ū�̸�
SELECT first_name
FROM employees
WHERE first_name > 'Shanta';

SELECT first_name
FROM employees
WHERE first_name >= 'a'; -- �ȳ��� 'a'�� 97

SELECT first_name
FROM employees
WHERE first_name >= 'A';

SELECT first_name, manager_id
FROM employees
WHERE manager_id = ''; -- ''�� null X        String = "" != String = null;

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
-- �̸� John, ������ 5000�̻�    
SELECT first_name, salary
FROM employees
WHERE first_name = 'John'
    AND salary >= 5000;

-- 2007�� 12�� 31�� ���Ŀ� �Ի��� ����� ����
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

-- BETWEEN ���� ������
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

-- LIKE �߿���
SELECT first_name
FROM employees
WHERE first_name LIKE 'G_ra_d';  -- _�ѹ���

SELECT first_name
FROM employees
WHERE first_name LIKE 'Al%';  -- % ���ڼ� ���� X

SELECT first_name
FROM employees
WHERE first_name LIKE '%Al%';   -- ���� ���̿� Al

SELECT first_name
FROM employees
WHERE first_name LIKE 'K%y';   -- ���� K____�ڰ� y

SELECT first_name
FROM employees
WHERE first_name LIKE '%y'; -- �� �ڰ� y

-- 2006�⵵�� �Ի��� ���
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '06/01/01' AND hire_date < '07/01/01';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '06%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '06/01%';

