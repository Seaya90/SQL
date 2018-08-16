/* ************************
SELECT [* | DISTINCT ]{�÷���,�÷���,...}
  FROM ���̺��
[WHERE ������]
[GROUP BY {�÷���,...}]
[HAVING ����]  --GROUP BY ���� ���� ����
[ORDER BY {�÷��� [ASC | DESC],... }] --ASC : ��������(�⺻/��������)
                                     --DESC : ��������
***************************/
--GROUP BY : ����Ÿ�� �׷����ؼ� ó���� ��� ���
--GROUP BY ���� ����ϸ� SELECT �׸��� GROUP BY ���� ���� �÷� 
----�Ǵ� �׷��Լ�(COUNT, SUM, AVG, MAX, MIN)�� ����� �� �ִ�
------------
--���Ű����� ���űݾ� �հ踦 ���Ͻÿ�
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
; 
--�ֹ�(�Ǹ�)���̺��� ���� ����Ÿ ��ȸ(�Ǽ�, �հ�, ���, �ּ�, �ִ�ݾ�)
SELECT CUSTID, COUNT(*), SUM(SALEPRICE), TRUNC(AVG(SALEPRICE)),
       MIN(SALEPRICE), MAX(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
--���� �������� ���� �Ǽ�, �հ�, ���, �ּ�, �ִ�ݾ�
SELECT CUST.NAME, 
       COUNT(*), --����(�Ǹ�)�Ǽ�
       SUM(ORD.SALEPRICE), --����(�Ǹ�) �հ�ݾ�
       TRUNC(AVG(ORD.SALEPRICE)), --����(�Ǹ�) ��ձݾ�
       MIN(ORD.SALEPRICE), --����(�Ǹ�) ���� ������ �� å
       MAX(ORD.SALEPRICE) --����(�Ǹ�) ���� ������ ��� å
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
 GROUP BY CUST.NAME
; 
--
SELECT CUST.NAME, 
       COUNT(*), --����(�Ǹ�)�Ǽ�
       SUM(ORD.SALEPRICE), --����(�Ǹ�) �հ�ݾ�
       TRUNC(AVG(ORD.SALEPRICE)), --����(�Ǹ�) ��ձݾ�
       MIN(ORD.SALEPRICE), --����(�Ǹ�) ���� ������ �� å
       MAX(ORD.SALEPRICE) --����(�Ǹ�) ���� ������ ��� å
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
   AND CUST.NAME IN ('�߽ż�', '��̶�')
 GROUP BY CUST.NAME
;  
----------------------
--HAVING�� : GROUP BY �� ���� ������� ����Ÿ���� �˻������� �ο�
--HAVING���� �ܵ����� ���� �� ���� GROUP BY ���� �Բ� ���
SELECT CUST.NAME, 
       COUNT(*), --����(�Ǹ�)�Ǽ�
       SUM(ORD.SALEPRICE), --����(�Ǹ�) �հ�ݾ�
       TRUNC(AVG(ORD.SALEPRICE)), --����(�Ǹ�) ��ձݾ�
       MIN(ORD.SALEPRICE), --����(�Ǹ�) ���� ������ �� å
       MAX(ORD.SALEPRICE) --����(�Ǹ�) ���� ������ ��� å
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
 GROUP BY CUST.NAME
 HAVING COUNT(*) >=3
;
--
SELECT CUST.NAME, 
       COUNT(*), --����(�Ǹ�)�Ǽ�
       SUM(ORD.SALEPRICE), --����(�Ǹ�) �հ�ݾ�
       TRUNC(AVG(ORD.SALEPRICE)), --����(�Ǹ�) ��ձݾ�
       MIN(ORD.SALEPRICE), --����(�Ǹ�) ���� ������ �� å
       MAX(ORD.SALEPRICE) --����(�Ǹ�) ���� ������ ��� å
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
 GROUP BY CUST.NAME
 HAVING MAX(ORD.SALEPRICE) >= 20000
;
----
-- �Ǹ�(����)������ 8000�� �̻��� ������ ������ �� �������
-- ���� ������ �Ѽ����� ���Ͻÿ�(�� 2�� �̻� ������ �����) 
SELECT CUSTID, COUNT(*)
  FROM ORDERS
 WHERE SALEPRICE >= 8000 --�Ǹ�(����) �ݾ��� 8000�� �̻� �ݾ�
 GROUP BY CUSTID --����(�׷�)
 HAVING COUNT(*) >= 2 --�Ǹ�(����)�Ǽ��� 2�� �̻��� 
;
--������ �̸� Ȯ��
SELECT C.NAME, COUNT(*)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND SALEPRICE >= 8000 --�Ǹ�(����) �ݾ��� 8000�� �̻� �ݾ�
 GROUP BY O.CUSTID, C.NAME --����(�׷�)
 HAVING COUNT(*) >= 2 --�Ǹ�(����)�Ǽ��� 2�� �̻��� 
;
----------------------------
--�ǽ� ����
--1. ���� �ֹ��� ������ ���ǸŰǼ�, �Ǹž�, ��հ�, ������, �ְ� ���ϱ�
--2. ������ �ֹ��� ������ �� ������ �� �Ǹž��� ���Ͻÿ�.
--3. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
--4. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� �����Ͻÿ�.
--5. ������ �ֹ��� �Ǽ��� �հ�ݾ�, ��� �ݾ��� ���ϰ� 
---- (3�� ���� ���� ������ ��� �˻�)
--���ܹ���: �����̺� �ִ� ����� å�� �������� ���� ����� ����?
---------------
--1. ���� �ֹ��� ������ ���ǸŰǼ�, �Ǹž�, ��հ�, ������, �ְ� ���ϱ�
SELECT COUNT(*) AS "TOTAL COUNT",
       SUM(SALEPRICE) AS "�Ǹž� �հ�",
       AVG(SALEPRICE) "��հ�", --AS ���� ����
       MIN(SALEPRICE) "������",
       MAX(SALEPRICE) "�ְ�"
  FROM ORDERS
;
--2. ������ �ֹ��� ������ �� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 ORDER BY SUM(O.SALEPRICE) DESC --���� ���� �ݾ� �����ڼ����� ����
; 

--3. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
SELECT C.NAME, O.SALEPRICE
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
;

--4. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� �����Ͻÿ�.
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;

--5. ������ �ֹ��� �Ǽ��� �հ�ݾ�, ��� �ݾ��� ���ϰ� 
---- (3�� ���� ���� ������ ��� �˻�)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), TRUNC(AVG(O.SALEPRICE))
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) < 3
;

--���ܹ���: �����̺� �ִ� ����� å�� �������� ���� ����� ����?





  
  
  
  
  
  