--��������(�μ�����, subquery)
--SQL��(SELECT, INSERT, UPDATE, DELETE) ���� �ִ� ������(SELECT)
-----------------------------------
--'������'�� ������ ������ �˻�
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER WHERE NAME = '������'; --CUSTID: 1
SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');
--
SELECT C.NAME, O.* 
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '������'
;
----
SELECT * FROM ORDERS
 WHERE CUSTID IN (SELECT CUSTID 
                   FROM CUSTOMER 
                  WHERE NAME IN ('������', '�迬��'));
------------------
--������ ���� ��� ������ �̸��� ���Ͻÿ�
--�������� WHERE���� ���
SELECT MAX(PRICE) FROM BOOK; --35000
SELECT * FROM BOOK
 WHERE PRICE = 35000;
--
SELECT * FROM BOOK
 WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);

--------------------
--���������� FROM���� ���
SELECT B.*
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE --��������
;
--
SELECT *
  FROM (SELECT * FROM CUSTOMER WHERE NAME IN ('������','�迬��')) C,
       ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
--
SELECT *
  FROM CUSTOMER C,
       ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME IN ('������', '�迬��')
;
----------------------------------
--SELECT ���� �������� ��뿹
SELECT O.ORDERID, O.CUSTID, O.BOOKID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, --����
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME, --å����
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;
--------------------------
--�������� ������ å ���(����)
--�� ����SQL -> �߰� SQL -> �� �ٱ��� SQL�� ����
SELECT BOOKNAME
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID = (SELECT CUSTID
                                     FROM CUSTOMER
                                    WHERE NAME = '������')
                  )
;                  
------------------------
--�ǽ�(�������� �̿�)
--1. �� ���̶� ������ ������ ���
--2. 20000�� �̻�Ǵ� å�� ������ �� ��� ��ȸ(��������,���ι�)
--3. '���ѹ̵��' ���ǻ��� ������ ������ ���̸� ��ȸ(��������,���ι�)
--4. ��ü å���� ��պ��� ��� å�� ��� ��ȸ(��������, ���ι�)
-----------











