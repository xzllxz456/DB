-- Standard Function ǥ���Լ�

-- dual table : ���� ���̺� -> ��� Ȯ�ο� �ӽ� ���̺�
SELECT 1 FROM DUAL;
SELECT 'A' FROM DUAL;
SELECT '��' FROM DUAL;
SELECT 23*34 FROM DUAL;



-- ���� �Լ�
-- CHR( N ) : ASCII ���� ���ڷ� ��ȯ�ϴ� �Լ�
SELECT CHR(65) FROM DUAL; -- A
SELECT CHR(49) FROM DUAL; -- 1
SELECT CHR(97) FROM DUAL; -- a

-- "�ȳ��ϼ���" + "�ǰ��ϼ���" = "�ȳ��ϼ���ǰ��ϼ���" <-- �ڹ�
--     || == +   <OR�����ڰ� �ƴ� ���ڿ����� �����Ҷ� ���>
SELECT '�ȳ��ϼ���' || '�ǰ��ϼ���' FROM DUAL;
SELECT '�� ������' || CHR(65) || '�Դϴ�' FROM DUAL;

-- LPAD(RPAD) : ��ĭ�� �������ڷ� ä���
SELECT LPAD('BBB', 10) FROM DUAL;
SELECT RPAD('BBB', 10) FROM DUAL;

SELECT LPAD('BBB', 10, '-') FROM DUAL;
SELECT LPAD('BBB', 10, '0') FROM DUAL;

-- INSTR == indexOf(c) == 2  abcd  <�ε����� ���� �Ѱ��ش�>
SELECT INSTR('123ABC456ABC', 'A') FROM DUAL;
SELECT INSTR('123ABC456ABC', 'A', 6) FROM DUAL; -- 6��° ������ �ִ� 'A'�� ã�´�
SELECT INSTR('123ABC456ABC', 'A' , 6, 1) FROM DUAL;-- 6��° ������ �ִ� ù��°'A'
SELECT INSTR('123ABC456ABCABC', 'A' , 6, 2) FROM DUAL;-- 6��° ������ �ִ� �ι�°'A'
SELECT INSTR('123ABC456ABC', 'D') FROM DUAL;-- ������ 0

-- REPLACE : ���ڿ� ġȯ
SELECT REPLACE('AAAAABC', 'A') FROM DUAL;
SELECT REPLACE('AAAAABC', 'A', 'a') FROM DUAL;
SELECT REPLACE('AAAAABC', 'AA', 'a') FROM DUAL;

-- TRANSLATE : ����ġȯ
SELECT TRANSLATE('AAAAABC', 'A', 'a') FROM DUAL;
SELECT TRANSLATE('AAAAABC', 'AA', 'a') FROM DUAL; -- AA�� �ڿ� A�� ���� ���ڸ� ���

-- ����
-- �ø�
SELECT CEIL(13.1) FROM DUAL;
-- ����
SELECT FLOOR(13.9) FROM DUAL;
-- �¼�
SELECT POWER(3, 2) FROM DUAL;
-- �ݿø�
SELECT ROUND(13.5) FROM DUAL;
SELECT ROUND(13.4) FROM DUAL;

-- ��ȣ ���1, 0 ,���� -1
-- SIGN
SELECT SIGN(12) FROM DUAL; -- 1
SELECT SIGN(0) FROM DUAL; -- 0
SELECT SIGN(-6) FROM DUAL; -- -1

-- ����
-- TRUNC
SELECT TRUNC(12.34567) FROM DUAL;
SELECT TRUNC(12.34567, 2) FROM DUAL; -- �Ҽ��� 2��° �ڸ������� �츲
SELECT TRUNC(12.34567, -1) FROM DUAL; -- ���� �ڸ����� ����

-- ASCII 
SELECT ASCII('A') FROM DUAL;
SELECT CHR(65) FROM DUAL;
-- ��ȯ �Լ�
-- TO_CHAR
-- DATE -> VARCHAR2
SELECT to_char(SYSDATE) FROM DUAL; -- ���ڿ�

SELECT to_char(SYSDATE, 'YYYY-MM-DD-HH-MI-SS') FROM DUAL;
SELECT to_char(SYSDATE, 'YYYY/MM/DD HH:MI:SS') FROM DUAL;
SELECT to_char(TO_DATE(SYSDATE,'YYYY/MM/DD HH:MI:SS'), 'YYYY/MM/DD HH:MI:SS') FROM DUAL;
SELECT SYSDATE FROM DUAL; 

SELECT TO_CHAR(10000000, '$999,999,999,999') FROM DUAL;

-- TO_DATE
-- VARCJAR2 -> DATE
SELECT TO_DATE('20201205') FROM DUAL;
SELECT TO_DATE('20201205', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('12052020', 'MMDDYYYY') FROM DUAL;

-- TO_NUMBER    VARCHAR2 -> NUMBER      Integer.parseInt()
SELECT to_number(('123') + 1) FROM DUAL;
SELECT '123' + 1 FROM DUAL;

-- LAST_DAY
SELECT LAST_DAY('20/11/01') FROM DUAL;

-- SUBSTR == ABCdef  subString(1, 3)  ->  �ڹ��� ��� BC subString(4)->ef
SELECT SUBSTR('ABCDEFG',3) FROM dual;  -- > CDEFG ���° ����
SELECT SUBSTR('ABCDEFG',3, 3) FROM dual; --> CDE ���° �����

