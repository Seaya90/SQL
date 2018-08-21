/* ***********************************
��(VIEW) : �ϳ� �Ǵ� �ϳ� �̻��� ���̺�� ����
     ����Ÿ�� �κ������� ���̺��� ��ó�� ����ϴ� ��ü
  
--��(VIEW) ������
CREATE VIEW ���̸� [(�÷���Ī1, �÷���Ī2, ... , �÷���Īn)]
AS
SELECT ����

--��(VIEW) ������
DROP VIEW ���̸�;
**************************************/   
SELECT O.*, B.BOOKNAME, C.NAME
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME = '������'
;
---------
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';

--��(VIEW) ������
CREATE VIEW VW_BOOK
AS 
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
-----
SELECT *
  FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%')
 WHERE PUBLISHER = '���ѹ̵��'
; 

---��(VIEW) ��� ����� ���̺� ����İ� ����
SELECT *
  FROM VW_BOOK
 WHERE PUBLISHER = '���ѹ̵��'
;
SELECT *
  FROM BOOK
 WHERE PUBLISHER = '���ѹ̵��'
;
--------------------------------
--��(VIEW) ���� - �÷���Ī(alias) ���
CREATE VIEW VW_BOOK2 
(BNAME, PUB, PRICE)
AS
--SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
SELECT BOOKNAME, PUBLISHER, PRICE
  FROM BOOK WHERE BOOKNAME LIKE '%�౸%';

----------------------
--��(VIEW)���� - ���ι����� ���� ����Ÿ
CREATE VIEW VW_ORDERS
AS
SELECT B.BOOKNAME, B.PUBLISHER, C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
 ORDER BY O.ORDERID
;
--�����
DROP VIEW VW_ORDERS;
-------------------
--�� ��� ��ȸ
SELECT * FROM VW_ORDERS WHERE NAME = '������';
SELECT * FROM VW_ORDERS WHERE NAME IN ('�迬��', '�߽ż�');
SELECT * FROM VW_ORDERS WHERE SALEPRICE >= 20000;

-------------------
--(�ǽ�) �並 ����, ��ȸ, ����
--1. VIEW ��Ī : VW_ORD_ALL
----�ֹ�����, å����, �������� ��� ��ȸ�� �� �ִ� ������ ��
CREATE VIEW VW_ORD_ALL 
AS
SELECT O.*, 
       B.BOOKNAME, B.PUBLISHER, B.PRICE,
       C.NAME, C.ADDRESS, C.PHONE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --��������
   AND O.CUSTID = C.CUSTID --��������
;

--2. �̻�̵��� �����ؼ� �Ǹŵ� å����, �Ǹűݾ�, �Ǹ��� ��ȸ
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '�̻�̵��'
; 
---
--��� ���� �����ϴ� ���´� FROM���� ���� SELECT���� �����ϴ� ���
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM (SELECT O.*, 
               B.BOOKNAME, B.PUBLISHER, B.PRICE,
               C.NAME, C.ADDRESS, C.PHONE
          FROM ORDERS O, BOOK B, CUSTOMER C
         WHERE O.BOOKID = B.BOOKID --��������
           AND O.CUSTID = C.CUSTID)
 WHERE PUBLISHER = '�̻�̵��'
; 

--3. �̻�̵�� ���ǻ��� å �߿��� �߽ż�, ��̶��� ������ å ���� ��ȸ
---- ����׸� : �����ѻ���̸�, å����, ���ǻ�, ����, �ǸŰ�, �Ǹ�����)
---- ���� : �����ѻ���̸�, �������� �ֱ�
SELECT NAME, BOOKNAME, PUBLISHER, PRICE, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '�̻�̵��'
   AND NAME IN ('�߽ż�', '��̶�')
 ORDER BY NAME, ORDERDATE DESC
;

--4. ����� ����� ��(VW_ORD_ALL) ����
--DROP VIEW VW_ORD_ALL;
