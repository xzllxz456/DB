/* **** ������(SEQUENCE)
SEQUENCE : DB���� �����ϴ� �ڵ�ä�� ��ü
���� : CREATE SEQUENCE ��������;
���� : DROP SEQUENCE ��������;

��������.NEXTVAL : ������ ��ȣ(��) ����
��������.CURRVAL : ���� �������� Ȯ��(NEXTVAL �� �� �̻� ���� ��)
****************************/

CREATE SEQUENCE "SEQUENCE1" 
MINVALUE 1 MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1
START WITH 1
CACHE 20 NOORDER  NOCYCLE;
----------------------------
SELECT SEQUENCE1.NEXTVAL FROM DUAL;
------------------------------
SELECT * FROM BOOK;
SELECT MAX(BOOKID), MAX(BOOKID) +1  FROM BOOK;
SELECT MAX(AAA), NVL(MAX(AAA),0) +1  FROM AAA; -- �����Ͱ� ������
-------------------
-- BOOK ���̺� INSERT �۾�, BOOKID �ִ밪 +1
INSERT INTO BOOK
    (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES ((SELECT NVL(MAX(BOOKID),0) + 1 FROM BOOK),
        'MAX(BOOKID) + 1', 'ITBOOK', 20000);
        COMMIT;
SELECT * FROM BOOK ORDER BY BOOKID DESC;
------------------------------------------------
--������ ���(���۹�ȣ ���� 50, NOCACHE)
CREATE SEQUENCE SEQ_BOOK
START WITH 50
INCREMENT BY 1 -- ������ ���� DEFAULT 1�� ����
NOCACHE -- ĳ�� ��� ����
;
SELECT SEQ_BOOK.NEXTVAL FROM DUAL;
-------------------------------
-- BOOK ���̺� ������ ��� �Է� ó��
INSERT INTO BOOK
    (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (SEQ_BOOK.NEXTVAL,
        'SEQ_BOOK.NEXTVAL ����', 'ITBOOK', 20000);
        COMMIT;
SELECT * FROM BOOK ORDER BY BOOKID DESC;