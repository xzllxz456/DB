/* �񱳱��� (�б�ó��) IF��
IF(���ǽ�) THEN ~ END IF;
IF(���ǽ�) THEN ~ ELSE ~ END IF;
IF(���ǽ�) THEN ~ ELSEIF ~ ELSEIF ~ ELSE ~ END IF;
************************************/
-- Ȧ��, ¦�� �Ǻ�
create or replace PROCEDURE PRC_IF(
    IN_NUM IN NUMBER
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>>�Է°� : ' || IN_NUM);
    -- Ȧ¦ �Ǻ�(���ڸ� 2�� ���� �������� 0�̸� ¦��)
    IF(MOD(IN_NUM, 2) = 0) THEN 
        DBMS_OUTPUT.PUT_LINE(IN_NUM || '¦��');
    ELSE
        DBMS_OUTPUT.PUT_LINE(IN_NUM || 'Ȧ��');
    END IF;
END;

--============
--�Է¹��� ���ڰ��� 4�� ���� ������ �� Ȯ��
create or replace PROCEDURE PRC_IF2(
    IN_NUM IN NUMBER
) AS
BEGIN
     DBMS_OUTPUT.PUT_LINE('>>>�Է°� : ' || IN_NUM);
     -- 4�� ���� ������ �� ���
     IF(MOD(IN_NUM, 4) = 0) THEN
         DBMS_OUTPUT.PUT_LINE('>>>4�� ���� ������ 0');
     ELSIF(MOD(IN_NUM, 4) = 1) THEN
        DBMS_OUTPUT.PUT_LINE('>>>4�� ���� ������ 1');  
     ELSIF(MOD(IN_NUM, 4) = 2) THEN
        DBMS_OUTPUT.PUT_LINE('>>>4�� ���� ������ 2');
     ELSE
        DBMS_OUTPUT.PUT_LINE('>>>4�� ���� ������ 3');
     END IF;
END;

--================================
-- �ݺ��� : FOR, WHILE 
-- FOR��
---- FOR ���� IN CHRLRKQT .. ������ LOOP ~ END LOOP;
------------------------------------------------
-- ���� �ϳ��� �Է� �޾Ƽ� �հ� ���(1~10 ���� ��)
CREATE OR REPLACE PROCEDURE PRC_FOR_SUM(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0; -- ���� ���� �� �ʱ�ȭ (�ʱⰪ 0)
BEGIN
    -- �Է¹��� �� ȭ�� ���
    DBMS_OUTPUT.PUT_LINE('>>> �Է°� : ' || IN_NUM);
    
    -- ���� : FOR������ �ݺ��� ó��
    FOR I IN 1 .. IN_NUM LOOP
    V_SUM := V_SUM + I;
     DBMS_OUTPUT.PUT_LINE('>>> I : ' || I);
    END LOOP;
   -- DBMS_OUTPUT.PUT_LINE('>>> ��°� : 1 ����'|| IN_NUM || ' ������ �հ� : ' || V_SUM);
    DBMS_OUTPUT.PUT('>>> ��°� : 1 ����'|| IN_NUM || ' ������ �հ� : ');
     DBMS_OUTPUT.PUT_LINE(V_SUM);
END;
SET SERVEROUTPUT ON;
CALL PRC_FOR_SUM(10);

--==========================
-- WHILE ��
-- WHILE (���ǽ�) LOOP ~ END LOOP;
-- ���� �ϳ��� �Է� �޾Ƽ� �հ� ���(1~10 ���� ��)
create or replace PROCEDURE PRC_WHILE_SUM(
    IN_NUM NUMBER -- IN ���� ����    
) AS
    V_SUM NUMBER := 0;
    I NUMBER := 1;
BEGIN
    --�Է� ���� �� ���
    DBMS_OUTPUT.PUT_LINE('>>> �Է°� : ' || IN_NUM);
    
    WHILE(I <= IN_NUM) LOOP 
    V_SUM := V_SUM + I;
    I := I + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~ ' || IN_NUM || '���� �հ� : ' || V_SUM);
END;

--==================================================
/* LOOP ~ END LOOP;
LOOP
    EXIT WHEN (���� ���ǽ�);
END LOOP;
****************************************/
CREATE OR REPLACE PROCEDURE LOOP1
AS 
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('I : ' || I);
        EXIT WHEN (I = 10); -- =, <>, !=, >, <, <=, >=
        I := I + 1;
    END LOOP;
END;

--====================================
/* (�ǽ�) ���ڸ� �ϳ� �Է� �޾Ƽ� 1 ~ ���ڱ����� �հ� ���ϱ�
���ν����� : PRC_SUM_EVENODD
? �Է°��� Ȧ���� Ȧ������ ���ϰ�
? �Է°��� ¦���� ¦������ ���ؼ�
���� �հ谪�� ȭ�鿡 ���
<�������>
? �Է¼���: �Է°�, Ȧ��/¦��, �հ� : �հ���
   ��¿�) �Է¼��� : 4, ¦��, �հ� : 6
   ��¿�) �Է¼��� : 5, Ȧ��, �հ� : 9
******************************************/
CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD(
    IN_NUM IN NUMBER
)
AS
    V_SUM NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM,2) = 0) THEN
        DBMS_OUTPUT.PUT(', ¦��');
    ELSE
         DBMS_OUTPUT.PUT(', Ȧ��');
    END IF;
    FOR I IN 1 .. IN_NUM LOOP
        IF(MOD(IN_NUM,2) = 0 AND MOD(I, 2) = 0) THEN
            V_SUM := V_SUM + I;
        ELSIF (MOD(IN_NUM,2) = 1 AND MOD(I, 2) = 1) THEN
            V_SUM := V_SUM + I;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(', �հ� : ' || V_SUM);
END;
CALL PRC_SUM_EVENODD(5);

CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD2(IN_NUM NUMBER)
AS
    START_NUM NUMBER;
    V_SUM NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT('�Է¼��� : ' || IN_NUM);
    START_NUM := MOD(IN_NUM, 2);
    IF(START_NUM = 0) THEN
        START_NUM := 2;
        DBMS_OUTPUT.PUT(', ¦��');
    ELSE
        DBMS_OUTPUT.PUT(', Ȧ��');
    END IF;
    WHILE (START_NUM <= IN_NUM) LOOP
        V_SUM := V_SUM + START_NUM;
        START_NUM := START_NUM + 2;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(', �հ� : ' || V_SUM);
END;

CALL PRC_SUM_EVENODD2(5);

CREATE OR REPLACE PROCEDURE PRC_SUM_EVENODD3(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    V_EVENNODD VARCHAR2(50) := 'Ȧ��';
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM, 2) = 0) THEN
       V_EVENNODD := '¦��';
    END IF;
    DBMS_OUTPUT.PUT('Ȧ¦���� : ' || V_EVENNODD);
    
    FOR I IN 1 .. IN_NUM LOOP
        -- ¦���϶�
        IF(MOD(I, 2) = 0 AND V_EVENNODD = '¦��') THEN
            V_SUM := V_SUM + I;
        END IF;
        -- Ȧ���϶�
        IF(MOD(I, 2) <> 0 AND V_EVENNODD = 'Ȧ��') THEN
        V_SUM := V_SUM + I;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('�Է°� : ' || IN_NUM || ' , ' || 
                   V_EVENNODD || ', �հ� : ' || V_SUM );
END;

create or replace PROCEDURE PRC_SUM_EVENODD4(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    V_EVENNODD VARCHAR2(50) := 'Ȧ��';
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM, 2) = 0) THEN
       V_EVENNODD := '¦��';
    END IF;
    DBMS_OUTPUT.PUT('Ȧ¦���� : ' || V_EVENNODD);

    FOR I IN 1 .. IN_NUM LOOP
        -- ¦���϶� ¦���� ���ϱ� Ȧ���϶� Ȧ���� ���ϱ�
        IF(MOD(IN_NUM, 2) = MOD(I, 2)) THEN
            V_SUM := V_SUM + I;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('�Է°� : ' || IN_NUM || ' , ' || 
                   V_EVENNODD || ', �հ� : ' || V_SUM );
END;

create or replace PROCEDURE PRC_SUM_EVENODD5(
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    V_EVENNODD VARCHAR2(50) := 'Ȧ��';
    I NUMBER := 1; --Ȧ���϶� ���� ��ȣ
BEGIN
    DBMS_OUTPUT.PUT('IN_NUM : ' || IN_NUM);
    IF(MOD(IN_NUM, 2) = 0) THEN
       V_EVENNODD := '¦��';
       I := 2; -- ¦���϶� ���۰�
    END IF;
    WHILE (I <= IN_NUM) LOOP
        V_SUM := V_SUM + I;
        I := I + 2;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('�Է°� : ' || IN_NUM || ' , ' || 
                   V_EVENNODD || ', �հ� : ' || V_SUM );
END;