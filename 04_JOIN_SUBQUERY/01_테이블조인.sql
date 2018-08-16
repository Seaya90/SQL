SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
-------------------------
--�������� ������ �ݾ��հ�
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --ID: 1
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT '������' AS NAME, SUM(SALEPRICE) 
  FROM ORDERS WHERE CUSTID = 1;
----------------
--��������(subquery) ���
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --ID: 1
SELECT * FROM ORDERS 
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');
------------------
--���̺� ����(join) ���
SELECT * FROM CUSTOMER WHERE CUSTID = 1;
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT *
  FROM CUSTOMER, ORDERS --������ ���̺� 
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --������ ����
;
--------
SELECT CUSTOMER.CUSTID, CUSTOMER.NAME, CUSTOMER.ADDRESS,
       ORDERS.SALEPRICE, ORDERS.ORDERDATE 
  FROM CUSTOMER, ORDERS
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
;
-------
--���̺��.�÷��� ������� ���̺� �÷� ����Ÿ ��ȸ
SELECT CUSTOMER.CUSTID, CUSTOMER.NAME, CUSTOMER.ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, ORDERS.SALEPRICE, ORDERS.ORDERDATE 
  FROM CUSTOMER, ORDERS
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --��������(���̺� ���ս� ���)
   AND CUSTOMER.NAME = '������' --�˻� ����(WHERE)
;
------
--�÷����� ���� ���̺����� ����(unique)�ϸ� ���̺� ���� ���� ����
SELECT CUSTOMER.CUSTID, NAME, ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, SALEPRICE, ORDERDATE 
  FROM CUSTOMER, ORDERS
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --��������(���̺� ���ս� ���)
   AND NAME = '������' --�˻� ����(WHERE)
;
--------------------
--��Ī(alias)������� �ܼ�ȭ
SELECT c.CUSTID, c.NAME, c.ADDRESS, c.PHONE,
       o.CUSTID AS ORD_CUSTID, o.SALEPRICE, o.ORDERDATE 
  FROM CUSTOMER C, ORDERS O
 WHERE c.CUSTID = o.CUSTID --��������(���̺� ���ս� ���)
   AND c.NAME = '������' --�˻� ����(WHERE)
;
--------------
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
----
SELECT O.ORDERID, O.BOOKID, B.BOOKNAME, B.PRICE, B.PUBLISHER,
       O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
 ORDER BY O.ORDERID
;
----------
--/////////////////////////////////////////////
--����: ���� ������ ������� �ʴ� ���(īƼ�ǰ� catesian product)
--���� ��� ���̺��� �� ����Ÿ�Ǽ� * ����Ÿ�Ǽ� ��� �߻�
SELECT *
  FROM BOOK B, ORDERS O
 ORDER BY B.BOOKID, O.ORDERID
;
---
SELECT *
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
 ORDER BY B.BOOKID, O.ORDERID
;
-----------------
--���� : 3���� ���̺� ����
SELECT *
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID -- O = B
   AND O.CUSTID = C.CUSTID -- O = C
;
--
SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID -- B = O
   AND O.CUSTID = C.CUSTID -- O = C
;
-----------------------------------
--3�� ���̺� ����
--����, ������ å ����, �ǸŰ���, �Ǹ�����, ���ǻ�� 
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, o.orderdate, b.publisher
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID -- O = B
   AND O.CUSTID = C.CUSTID -- O = C
;
--------------
--��̶��� ������ å����, ���԰���, ��������, ���ǻ�
--��̶� : CUSTOMER ��̶�
--������ : ORDERS
--å���� : BOOK
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --��������
   AND C.NAME = '��̶�'
;
---------------------------
--��̶��� ������ å �߿� 2014-01-01 ~ 2014-07-08���� �ڷ�
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --��������
   AND C.NAME = '��̶�'
   AND O.ORDERDATE BETWEEN TO_DATE('2014-01-01', 'YYYY-MM-DD')
                       AND TO_DATE('2014-07-08', 'YYYY-MM-DD')
;
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --��������
   AND C.NAME = '��̶�'
   AND O.ORDERDATE >= TO_DATE('2014-01-01', 'YYYY-MM-DD')
   AND O.ORDERDATE <= TO_DATE('2014-07-09', 'YYYY-MM-DD')
;     
-- ===============================================
--(�����ذ�) ���̺� ������ ���ؼ� �����ذ�(�ȵǸ� ���� SELECT������ �ܰ�������)
--�ǽ� : '�߱��� ��Ź��'��� å�� �� ���� �ȷȴ��� Ȯ�����ּ���.
--�ǽ� : '�߱��� ��Ź��'��� å�� �ȸ� ��¥�� ���ϼ���
--�ǽ� : '�߱��� ��Ź��'��� å(BOOK)�� ������(ORDERS) ���(CUSTOMER)��
----     �������� Ȯ��
--�ǽ� : '�߽ż�'�� ������ å���� �������� Ȯ��
--�ǽ� : '�߽ż�'�� ������ å���� �հ�ݾ� ���ϼ���
--�ǽ� : '�߱��� ��Ź��'��� å(BOOK)�� ������(ORDERS) ���(CUSTOMER)�� 
----    �������ڸ� ���ϼ���.
--�ǽ� : '�߽ż�', '��̶�'�� ������ å�� ���Աݾ�, �������ڸ� Ȯ��
--      (���� : ����, �������� ������)
--------------------------------------------------
--�ǽ� : '�߱��� ��Ź��'��� å�� �� ���� �ȷȴ��� Ȯ�����ּ���.
SELECT * FROM BOOK WHERE BOOKNAME = '�߱��� ��Ź��'; --BOOKID: 8
SELECT COUNT(*) FROM ORDERS WHERE BOOKID = 8;
---
SELECT '�߱��� ��Ź�� �ǸŰǼ�', COUNT(*)
--SELECT COUNT(*)
  FROM ORDERS O, BOOK B
 WHERE O.BOOKID = B.BOOKID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
--------------
--�ǽ� : '�߱��� ��Ź��'��� å�� �ȸ� ��¥�� ���ϼ���
SELECT B.BOOKNAME, O.ORDERDATE
  FROM ORDERS O, BOOK B
 WHERE O.BOOKID = B.BOOKID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
--------
--�ǽ� : '�߱��� ��Ź��'��� å(BOOK)�� ������(ORDERS) ���(CUSTOMER)��
----     �������� Ȯ��
SELECT B.BOOKNAME, C.NAME
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID AND O.CUSTID = C.CUSTID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
------
--�ǽ� : '�߽ż�'�� ������ å���� �������� Ȯ��
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '�߽ż�'
;
------
--�ǽ� : '�߽ż�'�� ������ å���� �հ�ݾ� ���ϼ���
SELECT '�߽ż� �����հ� ', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '�߽ż�'
;

--�ǽ� : '�߱��� ��Ź��'��� å(BOOK)�� ������(ORDERS) ���(CUSTOMER)�� 
----    �������ڸ� ���ϼ���.
SELECT B.BOOKNAME, C.NAME, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --��������
   AND O.CUSTID = C.CUSTID --��������
   AND B.BOOKNAME = '�߱��� ��Ź��' --�˻�����
;

--�ǽ� : '�߽ż�', '��̶�'�� ������ å�� ���Աݾ�, �������ڸ� Ȯ��
--      (���� : ����, �������� ������)
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --��������
   AND O.CUSTID = C.CUSTID --��������
   AND C.NAME IN ('�߽ż�', '��̶�')
 ORDER BY C.NAME, O.ORDERDATE
;  
---
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
--SELECT * 
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --��������
   AND O.CUSTID = C.CUSTID --��������
   AND (C.NAME = '�߽ż�' OR C.NAME = '��̶�')
 ORDER BY C.NAME, O.ORDERDATE
; 
-- ====================================
SELECT '�߽ż�', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '�߽ż�'
;
--
SELECT '��̶�', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '��̶�'
;
--------
/* ************************
SELECT [* | DISTINCT ]{�÷���,�÷���,...}
  FROM ���̺��
[WHERE ������
 GROUP BY {�÷���,...}
 HAVING ����  --GROUP BY ���� ���� ����
 ORDER BY {�÷���,... [ASC | DESC] --ASC : ��������(�⺻/��������)
                                  --DESC : ��������
]
***************************/
--�� �̸��� ����Ÿ�� ��Ƽ� �հ�
SELECT C.NAME, SUM(O.SALEPRICE),
       COUNT(*), ROUND(AVG(O.SALEPRICE), 2), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
;
SELECT C.NAME, O.SALEPRICE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 ORDER BY C.NAME, O.SALEPRICE
;

