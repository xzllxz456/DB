--PL/SQL ���ν���(PROCEDURE)
SET SERVEROUTPUT ON; --���� ������� ǥ�� ����

DECLARE -- ���� ����
    V_EMPID NUMBER(5);
    V_NAME VARCHAR2(30);
BEGIN -- ���๮ ����
    V_EMPID := 100; -- ġȯ��(���Թ�) ��ȣ :=
    V_NAME := 'ȫ�浿';
    
    DBMS_OUTPUT.PUT_LINE(V_EMPID || ' : ' || V_NAME);

END; --���๮ ��(���ν��� ��)
-----------------------------------------
--BOOK ���̺� ������ �� �Ϻθ� ȭ�� ���
DECLARE
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
-- SELECT ~ INTO ~ FROM ���·� DB������ �����ϰ� INTO���� ������ ����
-- (����) �Ѱ��� �����͸� ó������
    SELECT BOOKID, BOOKNAME, PUBLISHER,PRICE
        INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = 1;
    
     DBMS_OUTPUT.PUT_LINE(V_BOOKID || ' , ' || V_BOOKNAME || ' , ' ||
            V_PUBLISHER   || ' , ' || V_PRICE  );
END;  

--===================================================
/* ���� ���ν���(Stored procedure) --ȣ���ؼ� ����--SELECT ������ ���� �Ұ� ������ ���� ���� �ְ� �޴´�.
�Ű�����(�Ķ����, parameter) ����
- IN : �Է��� �ޱ⸸ �ϴ� �Ű�����(�⺻��)
- OUT : ��¸� �ϴ� �Ű�����
        (���� ���� ���� ����, ���ν��� ������ ȣ���� ������ ������ ���� �� ����)
- IN OUT : �Էµ� �ް�, ���� ������ ���� ��µ� ��
*******************************/
-- ���ν��� �����(���Ժ�)
CREATE OR REPLACE PROCEDURE BOOK_DISP
--�Ű����� ����� : ( )�ȿ� �ۼ�, ���й���  �޸����(,) 
(
    IN_BOOKID IN NUMBER
)
AS -- ���� �����(AS �Ǵ� IS ~ BEGIN �� ����) 
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
SELECT BOOKID, BOOKNAME, PUBLISHER,PRICE
        INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;
    
     DBMS_OUTPUT.PUT_LINE(V_BOOKID || ' , ' || V_BOOKNAME || ' , ' ||
            V_PUBLISHER   || ' , ' || V_PRICE  );
END;

-- ���ν��� ���� : EXECUTE ���ν�����; 
EXECUTE BOOK_DISP(3);
EXEC BOOK_DISP(3);

-- ���ν��� ���� : DROP PROCEDURE ���ν�����;
DROP PROCEDURE BOOK_DISP;