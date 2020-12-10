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
CONNECT BY A.MANAGER_ID = PRIOR A.EMPLOYEE_ID; -- 하향식

SELECT A.EMPLOYEE_ID, LPAD(' ', (LEVEL-1)*2) || A.FIRST_NAME, A.MANAGER_ID, B.EMPLOYEE_ID, B.FIRST_NAME
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID(+)
CONNECT BY PRIOR A.MANAGER_ID = A.EMPLOYEE_ID; -- 상향식