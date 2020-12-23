/* ******** CURSOR(Ŀ��) **************
�����ͺ��̽� Ŀ��(Cursor)�� �Ϸ��� �����Ϳ� ���������� �׼����� �� 
�˻� �� "���� ��ġ"�� �����ϴ� ������ ���

������Ŀ�� : SELECT, INSERT, UPDATE, DELETE ������ ����� ��
     DBMS�� CURSOR(Ŀ��)�� Open, Fetch, Close �ڵ� ó��
�����Ŀ�� : ���α׷������� ��������� Ŀ��(CURSOR)�� ������ ���

<Ŀ��(CURSOR) ��� ����>
1. ����(CURSOR Ŀ���� IS SELECT��)
2. Ŀ������(OPEN Ŀ����)
3. ����Ÿ����(FETCH Ŀ���� INTO)
4. Ŀ���ݱ�(CLOSE Ŀ����)
------------------------------------------
- SQL%ROWCOUNT : ���� ��
- SQL%FOUND : 1�� �̻��� ��� (������� ������ true)
- SQL%NOTFOUND : ������� �ϳ��� ������ true
- SQL%ISOPEN : �׻� false, �Ͻ��� Ŀ���� ���� ������ true
**************************************/

create or replace PROCEDURE DISP_ORDERS
AS
    -- 1. Ŀ�� ����(CURSOR Ŀ���� IS SELECT��)
    CURSOR C_ORDERS IS
    SELECT O.ORDERID, C.NAME, B.BOOKNAME,
        O.SALEPRICE, O.ORDERDATE
    FROM ORDERS O, BOOK B, CUSTOMER C
        WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
        ORDER BY O.ORDERID DESC;
    
    -- ����� ���� ����
    V_ORDERID orders.bookid%TYPE;
    V_COSTNAME customer.name%TYPE;
    V_BOOKNAME book.bookname%TYPE;
    V_SALEPRICE orders.saleprice%TYPE;
    V_ORDERDATE orders.orderdate%TYPE;
    
BEGIN
    -- Ŀ����� : ���õ� �����͸� ȭ�� ���
    -- Ŀ������(OPEN Ŀ����)
    OPEN C_ORDERS;
    LOOP
        -- 3. ������ ����(FETCH Ŀ���� INTO)
        FETCH C_ORDERS
        INTO V_ORDERID, V_COSTNAME, V_BOOKNAME, V_SALEPRICE, V_ORDERDATE;
        EXIT WHEN C_ORDERS%NOTFOUND;
        
        -- Ŀ���� ���� ������ ������ ȭ�� ���
        DBMS_OUTPUT.PUT_LINE(V_ORDERID|| ' , ' ||V_COSTNAME||' , ' || V_BOOKNAME||' , ' || 
                                V_SALEPRICE||' , ' || V_ORDERDATE);
    END LOOP;
    -- 4. Ŀ�� �ݱ�(CLOSE Ŀ����)
    CLOSE C_ORDERS; 
END;

-- Ʈ���� (��Ƽ�) � ������ �����ϸ� �ڵ�����