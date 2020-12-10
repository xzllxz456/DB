SELECT a.employee_id, a.first_name,
        a.manager_id as "����� ���", b.employee_id,
        b.first_name as "����� �̸�"
FROM employees a, employees b
WHERE a.manager_id = b.employee_id(+)
--CONNECT BY PRIOR a.manager_id = a.employee_id; --�����
CONNECT BY  a.manager_id = PRIOR a.employee_id; -- �����

-- ������ ���� ����, ����
SELECT A.EMPLOYEE_ID, LPAD(' ', (LEVEL-1)*2) || A.FIRST_NAME, A.MANAGER_ID, B.EMPLOYEE_ID, B.FIRST_NAME
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID(+)
CONNECT BY A.MANAGER_ID = PRIOR A.EMPLOYEE_ID; -- �����

SELECT A.EMPLOYEE_ID, LPAD(' ', (LEVEL-1)*2) || A.FIRST_NAME, A.MANAGER_ID, B.EMPLOYEE_ID, B.FIRST_NAME
FROM EMPLOYEES A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID(+)
CONNECT BY PRIOR A.MANAGER_ID = A.EMPLOYEE_ID; -- �����