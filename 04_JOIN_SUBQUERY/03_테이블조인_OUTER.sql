--���ܹ���: �����̺� �ִ� ����� å�� �������� ���� ����� ����?
--CUSTOMER ���̺� �ְ�, ORDERS ���̺� ���� ��� ã��
-----------------------------
--MINUS : ������ ó��
SELECT CUSTID
  FROM CUSTOMER
MINUS
SELECT CUSTID
  FROM ORDERS
;
-----
--��������(subquery)
SELECT CUSTID, NAME
  FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--------
--�ܺ�����(OUTER JOIN)
SELECT C.CUSTID, C.NAME
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;
-- =============================================
--��������(INNER JOIN, ��������) : �������̺� ��ο� �����ϴ� ����Ÿ �˻�
--�ܺ�����(OUTER JOIN) : ��� ���� ���̺� ����Ÿ�� �������� �ʾƵ�
---- ��� ����Ÿ�� ǥ���Ͽ� ��ġ���� �ʴ� ����Ÿ�� ���� ��ȸó�� �� �� ���
CREATE TABLE DEPT (
    ID VARCHAR2(10) primary key,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES('10', '�ѹ���');
INSERT INTO DEPT VALUES('20', '�޿���');
INSERT INTO DEPT VALUES('30', '�����');
COMMIT;
SELECT * FROM DEPT;
---------------
CREATE TABLE DEPT1 (
    ID VARCHAR2(10) primary key,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT1 VALUES('10', '�ѹ���');
INSERT INTO DEPT1 VALUES('20', '�޿���');
COMMIT;
SELECT * FROM DEPT1;
-------------------
CREATE TABLE DEPT2 (
    ID VARCHAR2(10) primary key,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT2 VALUES('10', '�ѹ���');
INSERT INTO DEPT2 VALUES('30', '�����');
COMMIT;
SELECT * FROM DEPT2;
---------------------------
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
SELECT * FROM DEPT2;
--DEPT1 = DEPT2
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID
; 
------------------
--ANSI : ǥ��SQL
SELECT *
  FROM DEPT1 D1 INNER JOIN DEPT2 D2 --���δ�� ���̺�
       ON D1.ID = D2.ID --���� ����
;       

--DEPT1���� �ְ� DEPT2���� ���� �μ�
--LEFT OUTER JOIN : ���� ���̺� ���� ��ü ǥ���ϰ� ������ ������ NULLǥ��
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+) --DEPT2 ���̺� ������ NULLǥ��
;
------
--ANSI SQL
SELECT *
  FROM DEPT1 D1 LEFT OUTER JOIN DEPT2 D2 --�������̺� �� ���
       ON D1.ID = D2.ID --��������
;       

SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+) --DEPT2 ���̺� ������ NULLǥ��
   AND D2.ID IS NULL --�������� �ִ� ����Ÿ ��ȸ(�������̺� NULL�� ����Ÿ)
;
-------------------------
--RIGHT OUTER JOIN : ���� ���̺� ���� ��ü ǥ���ϰ� ������ ������ NULLǥ��
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID(+) = D2.ID --�������� : ���� ���̺� ����
;
--ANSI SQL
SELECT *
  FROM DEPT1 D1 RIGHT OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;
--LEFT OUTER JOIN
SELECT *
  FROM DEPT2 D2, DEPT1 D1
 WHERE D2.ID = D1.ID(+)
;
-------------------------------
--FULL OUTER JOIN : ���� ���̺� �ִ� ����Ÿ�� ��� ǥ��
--ANSI ǥ�� FULL OUTER JOIN �� ���
SELECT D1.ID D1_ID, D1.NAME D1_NAME,
       D2.ID D2_ID, D2.NAME D2_NAME
  FROM DEPT1 D1 FULL OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;
---------------



