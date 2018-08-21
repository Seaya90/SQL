--=========================================================================
/******** �������� �ɼ� 
CASCADE : �θ����̺��� �������� ��Ȱ��ȭ(����) ��Ű�鼭 �����ϰ� �ִ�
   �ڳ�(SUB)���̺��� �������Ǳ��� ��Ȱ��ȭ(����)
********************************/
--�θ����̺� DEPT�� PK ��Ȱ��ȭ ��Ű�鼭 �ڳ����̺��� ��������(FK)�� ��Ȱ��ȭ
ALTER TABLE DEPT ENABLE PRIMARY KEY;
ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DEPTNO_FK;
ALTER TABLE EMP02 ENABLE CONSTRAINT SYS_C007028;
ALTER TABLE EMP03 ENABLE CONSTRAINT EMP03_DEPTNO_FK;

--DEPT ���̺��� PRIMARY KEY DISABLE ó���� ���
--�ܷ�Ű ����� ���̺��� ���������� ��Ȱ��ȭ �� �Ŀ� ó��
ALTER TABLE EMP01 DISABLE CONSTRAINT EMP01_DEPTNO_FK;
ALTER TABLE EMP02 DISABLE CONSTRAINT SYS_C007028;
ALTER TABLE EMP03 DISABLE CONSTRAINT EMP03_DEPTNO_FK;
--ORA-02297: cannot disable constraint (MADANG.SYS_C007016) - dependencies exist
ALTER TABLE DEPT DISABLE PRIMARY KEY;

--CASCADE �ɼ� ���
--�ܷ�Ű ������ �ڳ����̺��� �ܷ�Ű ������ ���ÿ� ��Ȱ��ȭ �ϸ鼭
--�θ� ���̺��� ���������� ��Ȱ��ȭ ó��(�ϰ��۾�)
ALTER TABLE DEPT DISABLE PRIMARY KEY CASCADE;

------------------------------------------
/* �������� �ɼ� : ON DELETE CASCADE
-- ���̺��� ���迡�� �θ����̺�(����Ÿ) ������
   �ڳ����̺�(����Ÿ)�� �Բ� ���� ó��
******************************/
CREATE TABLE C_TEST_MAIN (
    MAIN_PK NUMBER PRIMARY KEY,
    MAIN_DATE VARCHAR2(30)
);
CREATE TABLE C_TEST_SUB (
    SUB_PK NUMBER PRIMARY KEY,
    SUB_DATA VARCHAR2(30),
    SUB_FK NUMBER,
    CONSTRAINT C_TEST_SUB_FK FOREIGN KEY (SUB_FK)
    REFERENCES C_TEST_MAIN (MAIN_PK) ON DELETE CASCADE
);
INSERT INTO C_TEST_MAIN VALUES (1111, '1��° ���� ����Ÿ');
INSERT INTO C_TEST_MAIN VALUES (2222, '2��° ���� ����Ÿ');
INSERT INTO C_TEST_MAIN VALUES (3333, '3��° ���� ����Ÿ');
SELECT * FROM C_TEST_MAIN;
COMMIT;
----
INSERT INTO C_TEST_SUB VALUES (1, '1��° SUB ����Ÿ', 1111);
INSERT INTO C_TEST_SUB VALUES (2, '2��° SUB ����Ÿ', 2222);
INSERT INTO C_TEST_SUB VALUES (3, '3��° SUB ����Ÿ', 3333);
INSERT INTO C_TEST_SUB VALUES (4, '4��° SUB ����Ÿ', 3333);
SELECT * FROM C_TEST_SUB;
COMMIT;
--------
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 1111;
COMMIT;
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 3333;
COMMIT;

--===========================================
--���̺���� : �θ����̺�-�ڳ����̺� ���迡�� �θ����̺� ����
DROP TABLE C_TEST_MAIN; --ORA-02449: unique/primary keys in table referenced by foreign keys

--���1 : �������̺��� ��� ���� �� �θ� ���̺� ����
DROP TABLE C_TEST_SUB; --�ڳ����̺� ����
DROP TABLE C_TEST_MAIN;

--���2 : �������̺� �ִ� FK ������ ��� ������ �θ� ���̺����
--FK ��Ȱ��ȭ �������δ� �ȵ�. FK �����ؾ� ��
ALTER TABLE C_TEST_SUB DROP CONSTRAINT C_TEST_SUB_FK;
DROP TABLE C_TEST_MAIN;

--���3 : �θ����̺� ������ CASCADE CONSTRAINTS �ɼ� ���
--�������̺��� �������� ���� �� �������̺� ����ó��
DROP TABLE C_TEST_MAIN CASCADE CONSTRAINTS;

----------------------------
--PURGE : ������ ����(�����뿡 ������ �ʰ�)
DROP TABLE C_TEST_MAIN CASCADE CONSTRAINTS PURGE;









