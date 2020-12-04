-- DML
-- insert delete select(90%이상 사용 중요) update
/*
    Query
            Dao         <- Datebase(Container)
                list <--- file
                save ---> file
            Dto
    SELECT
        (값, COLUMN, 함수, SUB QUERY)
    FROM
        (TABLE명, SUB QUERY)    
*/
SELECT 1 FROM DUAL;

SELECT * FROM employees;
SELECT employee_id, FIRST_NAME, SALARY
FROM employees;

SELECT employee_id, first_name, SALARY
FROM employees;
-- Alias 별명
SELECT employee_id AS 사원번호, first_name as "이 름", SALARY"월급"
FROM employees;-- as는 생략가능

-- || 문자열 합하기
SELECT employee_id || first_name || SALARY
FROM employees;
SELECT first_name, last_name, salary, salary*12 as "연봉"
FROM employees;

