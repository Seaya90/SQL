/* *********************************
--���̺� ���� : CREATE TABLE ���̺�� ();
CREATE TABLE ���̺�� (
    �÷���1 ����ŸŸ��(ũ��) [��������],
    �÷���2 ����ŸŸ��(ũ��) [��������],
    ...
    �÷���n ����ŸŸ��(ũ��) [��������]
);

��������
-- PRIMARY KEY : �⺻Ű - NOT NULL + UNIQUE �������� ����
-- NOT NULL : ���� �ݵ�� �־�� ��(NULL�� ������)
-- UNIQUE : �÷������� ������ ��(���� ���� �ϳ��� ����)
-- CHECK : �ԷµǴ� �� üũ(�����ϸ� �Է�, �Ҹ��� �Է¾ȵ�)
-- DEFAULT : ���� �Էµ��� ���� �� �ʱⰪ ����
***********************************/
CREATE TABLE DDL_TEST (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL UNIQUE,
    PHONE VARCHAR2(20) DEFAULT '��ȭ����',
    KOR NUMBER(3) DEFAULT 0 CHECK(KOR BETWEEN 0 AND 100),
    REGDATE DATE DEFAULT SYSDATE
);
----
INSERT INTO DDL_TEST (ID) VALUES (1); --NAME �÷� NOT NULL �������� ����
INSERT INTO DDL_TEST (NAME) VALUES ('������'); --ID �÷� NOT NULL �������� ����
INSERT INTO DDL_TEST (ID, NAME) VALUES (1, 'ȫ�浿');

--����: check constraint (MADANG.SYS_C007020) violated
INSERT INTO DDL_TEST (ID, NAME, KOR) VALUES(2, '������', 200); --KOR: 0~100

INSERT INTO DDL_TEST (ID, NAME, KOR) VALUES(2, '������', 100);
------------------------------------
--======================================
-- ���̺�, �÷��� �ּ� �����
-- COMMENT ON TABLE ���̺�� IS '���̺��ּ�';
-- COMMENT ON COLUMN ���̺��.�÷��� IS '�÷��ּ�';

--���̺� ���� �ּ� �ۼ�
--COMMENT ON TABLE "MADANG"."BOOK"  IS 'å����';
COMMENT ON TABLE BOOK  IS 'å�����ּ�';

--�÷��� ���� �ּ���(����) �ۼ�
COMMENT ON COLUMN BOOK.BOOKID IS 'åID';
COMMENT ON COLUMN BOOK.BOOKNAME IS 'å����';
COMMENT ON COLUMN BOOK.PUBLISHER IS '���ǻ��';
COMMENT ON COLUMN BOOK.PRICE IS '�Ǹſ���';

--------------------------------------
--(�ǽ�) DDL_TEST ���̺� �ּ� �ޱ�
--DDL_TEST ���̺� �ּ�
COMMENT ON TABLE DDL_TEST IS '���̺���������';

--DDL_TEST ���̺��� �÷� �ּ�
COMMENT ON COLUMN DDL_TEST.ID IS '���̵�';
COMMENT ON COLUMN DDL_TEST.NAME IS '����';
COMMENT ON COLUMN DDL_TEST.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN DDL_TEST.KOR IS '��������';
COMMENT ON COLUMN DDL_TEST.REGDATE IS '�����';

--���̺�, �÷��� �ּ� Ȯ��(��ȸ) - ������ ��ȸ
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME = 'DDL_TEST';
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'DDL_TEST';

--============================================
/*************************************
<����Ÿ ����>
�����ͺ��̽� ���� �ý���(Database Management System, ���� DBMS)�� 
ȿ�������� ����ϱ� ���� �����ͺ��̽��� ����� ������ ����� ���̴�
--����ڿ��� ��(VIEW)���·� ����
************************************/ 
--��� ������ ����Ÿ ���� ����
SELECT * FROM DICT ORDER BY TABLE_NAME;

--��ġ�Ǿ� �ִ� ����Ÿ���̽��� ���� ���� Ȯ��
SELECT * FROM V$VERSION;

DESC BOOK;
SELECT * FROM TAB;

--���̺� ���� Ȯ��
SELECT * FROM USER_TABLES; --���̺�����
--�÷����� Ȯ��
SELECT * FROM USER_TAB_COLS ORDER BY TABLE_NAME, COLUMN_ID;
SELECT * FROM USER_TAB_COLUMNS ORDER BY TABLE_NAME, COLUMN_ID;

-------------
--���������� Ȯ��
--USER_CONS_COLUMNS : �÷��� �Ҵ�� �������� ��ȸ
--USER_CONSTRAINTS : ����(DB)�� ������ ��� ���� ���� ��ȸ
SELECT * FROM USER_CONS_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;

--�������� ��ȸ
SELECT A.TABLE_NAME,
       A.COLUMN_NAME,
       A.CONSTRAINT_NAME,
       B.CONSTRAINT_TYPE,
       DECODE(B.CONSTRAINT_TYPE,
              'P', 'PRIMARY KEY',
              'U', 'UNIQUE',
              'C', 'CHECK OR NOT NULL',
              'R', 'FOREIGN KEY') CONSTRINT_TYPE_DESC
  FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
 WHERE A.TABLE_NAME = B.TABLE_NAME
   AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
   AND A.TABLE_NAME = 'DDL_TEST'
 ORDER BY 1
;   
   









