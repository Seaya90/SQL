/* **************************** 
-- INSERT ��
INSERT INTO ���̺��
       (�÷���1, �÷���2, ..., �÷���n)
VALUES (��1, ��2, ... , ��n);  
*********************************/
SELECT * FROM BOOK;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (30, '�ڹٶ� �����ΰ�', 'ITBOOK', 30000);  
COMMIT;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (31, '�ڹٶ� �����ΰ�2', 'ITBOOK', 30000); 
---
-- �÷����� �������� �ʴ� ��� 
-- ���̺� ������ �÷��� ������� ����Ÿ �Էµǰ�,
-- �ݵ�� ��� �÷��� ���� �Է��ؾ� �Ѵ�.
INSERT INTO BOOK
VALUES (32, '�ڹٶ� �����ΰ�3', 'ITBOOK', 30000);
INSERT INTO BOOK
VALUES (33, 'ITBOOK', '�ڹٶ� �����ΰ�3', 30000);
--�÷��� ���� �����ϴ� ��� 
--SQL ����: ORA-00947: not enough values
INSERT INTO BOOK
VALUES (34, '�ڹٶ� �����ΰ�4', 'ITBOOK');

--------------
--�÷����� �ۼ��ϸ�, �÷��� �ۼ��׸񿡸� ����Ÿ ��Ī �Է�
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER)
VALUES (35, '�ڹٶ� �����ΰ�5', 'ITBOOK');
--
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PRICE, PUBLISHER)
VALUES (36, '�ڹٶ� �����ΰ�6', 30000, 'ITBOOK'); 
------------------
--�ϰ��Է� : ���̺��� ����Ÿ�� �̿��ؼ� ����Ÿ �Է�
--IMPORTED_BOOK -> BOOK : �ϰ��Է�
INSERT INTO BOOK
SELECT BOOKID,BOOKNAME, PUBLISHER, PRICE
  FROM IMPORTED_BOOK
;

/* *********************************
--UPDATE��
UPDATE ���̺��
   SET �÷���1 = ��1, �÷���2 = ��2, ..., �÷���n = ��n
 [WHERE ������� ]
*********************************/
SELECT * FROM CUSTOMER;
--�ڼ����� �ּ� : '���ѹα� ����' -> '���ѹα� �λ�'
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� �λ�'
 WHERE NAME = '�ڼ���'
;   
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
COMMIT;
---------
--�ڼ��� �ּ�, ��ȭ��ȣ : '���ѹα� ����', '010-1111-2222'
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� ����',
       PHONE = '010-1111-2222'
 WHERE NAME = '�ڼ���'
; 
------------------------
--�ڼ��� �ּ� ����: �迬���� �ּҿ� �����ϰ� ����
SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�迬��';
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER 
                   WHERE NAME = '�迬��')
 WHERE NAME = '�ڼ���'
;
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
-----------
--�ڼ��� �ּ�, ��ȭ��ȣ ���� : �߽ż� ������ �����ϰ�
