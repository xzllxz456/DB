/* �Լ�(FUNCTION)
���� �� ���� ����(RETURN) �ϴ� ���α׷� -- ������ �ʼ�
CREATE OR REPLACE FUNCTION FUNCTION1 
(
  PARAM1 IN VARCHAR2 -- �Ķ���� �ۼ�
) RETURN VARCHAR2 AS  -- ���� ������ Ÿ�� ����
BEGIN
  RETURN NULL; -- ���� ��
END;
************************************/
-- BOOKID�� å���� Ȯ�� �Լ�(�Ķ���Ͱ� : BOOKID, RETURN�� : BOOKNAME)
create or replace FUNCTION GET_BOOKNAME(
    IN_ID IN NUMBER
) RETURN VARCHAR2 AS
    V_BOOKNAME book.bookname%TYPE;
BEGIN
    --DBMS_OUTPUT.PUT_LINE('IN_ID : ' || IN_ID);
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    RETURN V_BOOKNAME;  --  ���ϰ� ���� (å ����)
END;
-------------------------------------------
-- �Լ��� ���
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID) BOOKNAME
FROM BOOK;
------------
--SELECT ���� ����� �Լ� ���
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME
FROM ORDERS O;

-- WHERE ���� ���
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME
FROM ORDERS O
WHERE GET_BOOKNAME(O.BOOKID) = '�߱��� ��Ź��'
;
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME
FROM ORDERS O
WHERE GET_BOOKNAME(O.BOOKID) = '���� �ܰ躰���'
;

--====================================
/* (�ǽ�) ��ID ���� �޾Ƽ� ������ �����ִ� �Լ� �ۼ�(CUSTOMER ���̺� ���)
�Լ��� : GET_CUSTNAME
�Լ��� ����ؼ� ORDERS ���̺� ������ ��ȸ
    GET_BOOKNAME, GET_CUSTNAME �Լ���� �ֹ�(�Ǹ�)������ å����, ���� ��ȸ
***************************************/
CREATE OR REPLACE FUNCTION GET_CUSTNAME(
    IN_ID NUMBER
)RETURN VARCHAR2
AS
   -- V_BOOKNAME book.bookname%TYPE;
    V_NAME customer.name%TYPE;
BEGIN
    SELECT NAME INTO V_NAME FROM CUSTOMER WHERE CUSTID = IN_ID;
    RETURN V_NAME;
END;
SET SERVEROUT ON;
SELECT O.*, GET_BOOKNAME(O.BOOKID) BOOKNAME , GET_CUSTNAME2(O.CUSTID) CUSTNAME
FROM ORDERS O;
SELECT O.*, 
    (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME,
    GET_CUSTNAME2(O.CUSTID) CUSTNAME
FROM ORDERS O;
CALL GET_CUSTNAME2(1);

CREATE OR REPLACE FUNCTION GET_CUSTNAME2(IN_CUSTID NUMBER)
    RETURN VARCHAR2
AS
    V_NAME CUSTOMER.NAME%TYPE;
BEGIN
    SELECT NAME
    INTO V_NAME
    FROM CUSTOMER
    WHERE CUSTID = IN_CUSTID;
    
    DBMS_OUTPUT.PUT_LINE('�ɳ� ��ġ~~!');
    RETURN V_NAME;
end;

--------------------------------------------------------
SELECT O.*, b.bookid, c.name
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE o.bookid = b.bookid -- ��������
AND o.custid = c.custid -- ��������
AND C.NAME = '������' -- WHERE ����
;
-------
SELECT O.*, b.bookid, c.name
FROM ORDERS O INNER JOIN BOOK B
    ON O.BOOKID = B.BOOKID -- ��������
    JOIN CUSTOMER C
    ON O.CUSTID = C.CUSTID -- ��������
WHERE C.NAME = '������' -- WHERE ����
;
--------------------------------------
