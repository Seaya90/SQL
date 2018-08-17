--�����������(���������� ���������� ���εǾ� ����)
--------------------
--���ǻ纰�� ���ǻ纰 ��� �������ݺ��� ��� ���� ����� ���Ͻÿ�
SELECT *
  FROM BOOK B
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK
                 WHERE PUBLISHER = '�½�����')
   AND B.PUBLISHER = '�½�����'
;
----
--���� SELECT���� ����Ÿ �ϳ��� ó���� ������ �������̺��� ����
--���ؼ� �������� ������ ����Ǵ� ���·� ó��
SELECT *
  FROM BOOK B
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK
                 WHERE PUBLISHER = B.PUBLISHER)
;
----- JOIN��
--���ǻ纰 ��� ���� ����
SELECT PUBLISHER, AVG(PRICE)
  FROM BOOK
 GROUP BY PUBLISHER
;
----
SELECT *
  FROM BOOK B
     , (SELECT PUBLISHER, AVG(PRICE) PUB_AVG_PRICE
          FROM BOOK
         GROUP BY PUBLISHER
       ) AVG
 WHERE B.PUBLISHER = AVG.PUBLISHER 
   AND B.PRICE >= AVG.PUB_AVG_PRICE
;
------------------
-- SELECT ���� ���� �����������
SELECT O.*
     , (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUST_NAME
     , (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOK_NAME
  FROM ORDERS O
;

---------------------------------------
--EXISTS : ���翩�� Ȯ�ν� ���(������ true)
--NOT EXISTS : �������� ���� �� ture
SELECT BOOKNAME, '����Ÿ ����'
  FROM BOOK
 WHERE EXISTS (SELECT 1
                 FROM BOOK
                WHERE BOOKNAME LIKE '%�౸%' 
              )
;
--�ֹ������� �ִ� ���� �̸��� ��ȭ��ȣ�� ã���ÿ�
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID
                    FROM ORDERS)
;
-- ===> EXISTS ����
SELECT *
  FROM CUSTOMER C
 WHERE EXISTS (SELECT 1
                 FROM ORDERS
                WHERE CUSTID = C.CUSTID)
; 
---- NOT EXISTS
SELECT *
  FROM CUSTOMER C
 WHERE NOT EXISTS (SELECT 1
                 FROM ORDERS
                WHERE CUSTID = C.CUSTID)
; 
--=====================================
--UNION, UNION ALL : ������ ó��
--��, ��ȸ�ϴ� �÷��� �̸�, ����, ����, Ÿ���� ��ġ�ϵ��� �ۼ�
--UNION : �ߺ�����Ÿ�� �����ϰ� ������
--UNION ALL : �ߺ�����Ÿ�� �����ؼ� ������
---------------
-- UNION ��� ����
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3)
 ORDER BY NAME
;
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5)
 ORDER BY NAME
;
----- ��̶� ����Ÿ�� 1���� ���
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
UNION
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(��̶�), �߽ż�, �ڼ���
;
---- UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(��̶�), �߽ż�, �ڼ���
;
----------------------------
--MINUS : ������(���⿬��)
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
MINUS
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(��̶�), �߽ż�, �ڼ���
;
---------------------
--INTERSECT : ������(�ߺ�����Ÿ ��ȸ) - ���ι��� ����� ��� ����
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
INTERSECT
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(��̶�), �߽ż�, �ڼ���
;
--- JOIN ��
SELECT A.*
  FROM (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
       ) A,
       (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (3, 4, 5) --(��̶�), �߽ż�, �ڼ���
       ) B
 WHERE A.CUSTID = B.CUSTID
   AND A.NAME = B.NAME
;   





