/******************************* 
����Ŭ�� �����Լ� - ���ڿ�, ����, ��¥ ���� �Լ�
<���ڿ� ���� �����Լ�>
UPPER : �빮�ڷ� ����
LOWER : �ҹ��ڷ� ����
INITCAP : ù ���ڸ� �빮�ڷ� �������� �ҹ���
LENGTH : ���ڿ��� ����(���ڴ���)
LENGTHB : ���ڿ��� ����(BYTE ����)
SUBSTR(���, ������ġ, ����) : ���ڿ��� �Ϻ� ����
   (������ġ�� 1���� ����, �����ʿ��� �����ϴ� ��� ���̳ʽ�(-)�� ���)
INSTR(���, ã�¹���) : ����ڿ��� ã�¹��� ��ġ�� ����
INSTR(���, ã�¹���, ������ġ)
INSTR(���, ã�¹���, ������ġ, nth) : nth ã������ ������(3 : 3��° ã�� ��)
TRIM('���ڿ�') : ���� ���� ����
LTRIM('���ڿ�') : ���ʿ� �ִ� ���� ����
RTRIM('���ڿ�') : �����ʿ� �ִ� ���� ����
CONCAT(���ڿ�1, ���ڿ�2) : ���ڿ� ���� - ���ڿ�1 || ���ڿ�2
LPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : ���ʿ� ����
RPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : �����ʿ� ����
REPLACE(����ڿ�, ã������, ���湮��) : ���ڿ����� ã�����ڸ� ����
********************************/
SELECT * FROM DUAL; --����Ŭ���� �����ϴ� �������̺�
SELECT 1000 * 1234 FROM DUAL;
------
--UPPER : �빮�ڷ� ����
--LOWER : �ҹ��ڷ� ����
--INITCAP : ù ���ڸ� �빮�ڷ� �������� �ҹ���
SELECT BOOKNAME, UPPER(BOOKNAME) FROM BOOK;
SELECT UPPER('Olympic Champions') FROM DUAL;
SELECT LOWER('OLYMPIC CHAMPIONS') FROM DUAL;
SELECT INITCAP('OLYMPIC CHAMPIONS') FROM DUAL;
SELECT INITCAP('olympic champions') FROM DUAL; --Olympic Champions
SELECT * FROM BOOK WHERE BOOKNAME LIKE 'OLYMPIC%';
SELECT * FROM BOOK WHERE BOOKNAME LIKE 'olympic%';
SELECT * FROM BOOK WHERE BOOKNAME LIKE 'Olympic%';
SELECT * FROM BOOK 
WHERE UPPER(BOOKNAME) LIKE 'OLYMPIC%';
--------------
--TRIM('���ڿ�') : ���� ���� ����
--LTRIM('���ڿ�') : ���ʿ� �ִ� ���� ����
--RTRIM('���ڿ�') : �����ʿ� �ִ� ���� ����
SELECT '   TEST   ', TRIM('   TEST   ') FROM DUAL;
SELECT '   TEST   ', LTRIM('   TEST   ') FROM DUAL;
SELECT '   TEST   ', RTRIM('   TEST   ') FROM DUAL;
------------
--CONCAT(���ڿ�1, ���ڿ�2) : ���ڿ� ���� - ���ڿ�1 || ���ڿ�2
SELECT CONCAT('HELLO ', 'WORLD!!!') FROM DUAL;
SELECT 'HELLO ' || 'WORLD!!!' FROM DUAL;

--LPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : ���ʿ� ����
--RPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : �����ʿ� ����
SELECT LPAD('OLYMPIC', 10, '*') FROM DUAL;
SELECT RPAD('OLYMPIC', 10, '*') FROM DUAL;
SELECT LPAD('OLYMPIC', 10) FROM DUAL;
SELECT RPAD('OLYMPIC', 16, '*!') FROM DUAL;

--LENGTH : ���ڿ��� ����(���ڴ���)
--LENGTHB : ���ڿ��� ����(BYTE ����)
SELECT LENGTH('ABCDE123') FROM DUAL; --���ڴ���
SELECT LENGTHB('ABCDE123') FROM DUAL; --BYTE����

SELECT LENGTH('ȫ�浿123') FROM DUAL;  --���ڴ���
SELECT LENGTHB('ȫ�浿123') FROM DUAL; --BYTE����

--SUBSTR(���, ������ġ, ����) : ���ڿ��� �Ϻ� ����
--   (������ġ�� 1���� ����, �����ʿ��� �����ϴ� ��� ���̳ʽ�(-)�� ���)
SELECT SUBSTR('ȫ�浿123', 1, 3) FROM DUAL; --ȫ�浿
SELECT SUBSTR('ȫ�浿123', -3, 3) FROM DUAL; --123
SELECT SUBSTR('ȫ�浿12345', 4) FROM DUAL; --12345
SELECT SUBSTR('ȫ�浿12345', -3) FROM DUAL; --123
------------------------
--INSTR(���, ã�¹���) : ����ڿ��� ã�¹��� ��ġ�� ����
--INSTR(���, ã�¹���, ������ġ)
--INSTR(���, ã�¹���, ������ġ, nth) : nth ã������ ������(3 : 3��° ã�� ��)
SELECT INSTR('900101-1234567', '-') FROM DUAL; --7 ��ġ��
SELECT INSTR('900101-1234567', '*') FROM DUAL; --������ 0
SELECT INSTR('900101-1234567', '34') FROM DUAL; --10 ��ġ��
SELECT INSTR('900101-1234567', '1', 7) FROM DUAL;
SELECT INSTR('900101-1234567', '1', 1, 3) FROM DUAL;

--------------
--REPLACE(����ڿ�, ã������, ���湮��) : ���ڿ����� ã�����ڸ� ����
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'A', 'O') FROM DUAL;
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'JAVA', 'WORLD!!!') FROM DUAL;





