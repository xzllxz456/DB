/*
    Ư��  Query
    
    CASE
    DECODE

*/

--CASE -> SWITCH ���� ���
SELECT employee_id, first_name, phone_number,
    CASE SUBSTR(phone_number, 1, 3)
        WHEN '515' THEN '����'
        WHEN '590' THEN '�λ�'
        WHEN '659' THEN '����'
        WHEN '603' THEN '����'
        ELSE '��Ÿ'
    END
FROM employees;

SELECT employee_id, first_name, phone_number,
    CASE 
    
        WHEN SUBSTR(phone_number, 1, 3) = '515' THEN '����'
        WHEN SUBSTR(phone_number, 1, 3) = '590' THEN '�λ�'
        WHEN SUBSTR(phone_number, 1, 3) = '659' THEN '����'
        WHEN SUBSTR(phone_number, 1, 3) = '603' THEN '����'
        ELSE '��Ÿ'
    END
FROM employees;

--DECODE
SELECT employee_id, first_name, phone_number,
    DECODE(SUBSTR(phone_number, 1, 3),
        '515', '����',
        '590', '�λ�',
        '659', '����',
        '603', '����',
        '��Ÿ'
        )
FROM employees;
