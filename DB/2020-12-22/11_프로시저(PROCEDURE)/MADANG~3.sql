-- ���ν��� �Ķ���� ���� : IN, OUT ���
create or replace PROCEDURE GET_BOOKINFO(
    IN_BOOKID IN NUMBER,
    OUT_BOOKNAME OUT VARCHAR2, -- ũ�Ⱑ �ʿ����
    OUT_PUBLISHER OUT VARCHAR2,
    OUT_PRICE OUT NUMBER
) AS
-- %TYPE ��� : ���̺��. �÷���%TYPE
-- ���̺� �÷��� ������ Ÿ������ ����(����������� ����)
    V_BOOKID BOOK.BOOKID%TYPE;
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER BOOK.PUBLISHER%TYPE;
    V_PRICE BOOK.PRICE%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Ű����� ��: ' || IN_BOOKID || ' , ' || OUT_BOOKNAME
                        || ' , ' || OUT_PUBLISHER   || ' , ' || OUT_PRICE);
             
SELECT BOOKID, BOOKNAME, PUBLISHER,PRICE
        INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;
    
    -- ȣ���� ������ �����͸� �����ϱ� ���ؼ� OUT������ ������ ����
        OUT_BOOKNAME := V_BOOKNAME;
        OUT_PUBLISHER := V_PUBLISHER;
        OUT_PRICE := V_PRICE;
     DBMS_OUTPUT.PUT_LINE(V_BOOKID || ' , ' || V_BOOKNAME || ' , ' ||
            V_PUBLISHER   || ' , ' || V_PRICE  );

END;      
--===============================================================
-- ���� ���ν����� ȣ���ؼ� OUT���� ���޵� �� Ȯ�ο� ���ν��� 
CREATE OR REPLACE PROCEDURE GET_BOOKINFO_TEST (
  IN_BOOKID IN NUMBER 
) AS 
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER BOOK.PUBLISHER%TYPE;
    V_PRICE BOOK.PRICE%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Է¹��� ��(ID) : ' || IN_BOOKID);
    
    -- GET_BOOKINFO ���ν��� ����(ȣ��)
    GET_BOOKINFO(IN_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE);
    
    -- GET_BOOKINFO ���ν��� ����(ȣ��) �� ���޹��� �� Ȯ�� 
    DBMS_OUTPUT.PUT_LINE('>>>>BOOKINFO OUT�� : ' || V_BOOKNAME
                                    || '/' || V_PUBLISHER || '/' || V_PRICE);
END GET_BOOKINFO_TEST;

--===================================================================================================================
/* (�ǽ�) ���ν��� �ۼ��ϰ� �����ϱ�
�����̺�(CUSTOMER)�� �ִ� ������ ��ȸ ���ν��� �ۼ�
- ���ν����� : GET_CUSTINFO
- �Է¹޴� �� : ��ID
- ó�� : �Է¹��� ��ID�� �ش��ϴ� �����͸� ã�Ƽ� ȭ�� ���
- ����׸� : ��ID, ����, �ּ�, ��ȭ��ȣ
********************************************/
CREATE OR REPLACE PROCEDURE GET_CUSTINFO(
    IN_CUSTID IN NUMBER
) AS
    V_CUSTID customer.custid%TYPE;
    V_NAME customer.name%TYPE;
    V_ADDRESS customer.address%TYPE;
    V_PHONE customer.phone%TYPE;

BEGIN
    SELECT CUSTID, NAME, ADDRESS, PHONE 
    INTO V_CUSTID, V_NAME, V_ADDRESS, V_PHONE
    FROM CUSTOMER
    WHERE custid = IN_CUSTID;
    
    DBMS_OUTPUT.PUT_LINE(V_CUSTID || ' . '||V_NAME|| ' . '||V_ADDRESS|| ' . '||V_PHONE);
END;
SET SERVEROUTPUT ON;
CALL GET_CUSTINFO(3);