/* **************
��(VIEW) : �ϳ� �Ǵ� �� �̻��� ���̺�� ����
    �������� �κ������� ���̺��� ��ó�� ����ϴ� ��ü(�������̺�)
CREATE [OR REPLACE] [FORCE] VIEW ���Ī [(�÷���Ī1, �÷���Ī2, ..., �÷���Īn)]
AS 
SELECT ����
[�ɼ�];
--�б����� �ɼ� : WITH READ ONLY

--�� ����
DROP VIEW ���̸�;
*******************/
CREATE OR REPLACE VIEW EMP_DEPT
AS 
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, E.SALARY, E.HIRE_DATE
     , E.DEPARTMENT_ID
     , D.DEPARTMENT_NAME, D.MANAGER_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-----------
-- FORCE : ���̺��� ��� �並 ������ ����
CREATE FORCE VIEW TEST AS SELECT * FROM TEST999;
CREATE TABLE TEST999 (
    AAAA VARCHAR2(30)
);
INSERT INTO TEST999 VALUES ('ȫ�浿');
COMMIT;
SELECT * FROM TEST;

--�� ����
DROP VIEW TEST;
--------------------
SELECT *
FROM EMP_DEPT
ORDER BY EMPLOYEE_ID
;









