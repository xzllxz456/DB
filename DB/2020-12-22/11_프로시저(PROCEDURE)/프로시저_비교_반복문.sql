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