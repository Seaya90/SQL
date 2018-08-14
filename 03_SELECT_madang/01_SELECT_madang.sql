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
SELECT * FROM BOOK
ORDER BY BOOKNAME; --å�̸� ���� �����ټ� ����
SELECT * FROM BOOK ORDER BY BOOKNAME DESC;
--���ǻ� ���� ��������, �ݾ� ū�ݾ� ����
SELECT * FROM BOOK
ORDER BY PUBLISHER, PRICE DESC;
---------------
--AND, OR, NOT
--AND : ���ǻ� ���ѹ̵��, �ݾ��� 3���� �̻��� å ��ȸ
SELECT *
  FROM BOOK
 WHERE PUBLISHER = '���ѹ̵��' AND PRICE >= 30000
;
--OR : ���ǻ� ���ѹ̵�� �Ǵ� �̻�̵�� ���� ������ å
SELECT * FROM BOOK
 WHERE PUBLISHER = '���ѹ̵��' OR PUBLISHER = '�̻�̵��'
;
--NOT : ���ǻ� �½������� �����ϰ� ������ ��ü
SELECT * FROM BOOK
 WHERE NOT (PUBLISHER = '�½�����') --�� ��� ����
;
SELECT * FROM BOOK
 WHERE PUBLISHER != '�½�����' 
;
SELECT * FROM BOOK
 WHERE PUBLISHER <> '�½�����'
;
--�½�����, ���ѹ̵�� ���ǻ簡 �ƴ� å
SELECT * FROM BOOK
 WHERE NOT (PUBLISHER = '�½�����' OR PUBLISHER = '���ѹ̵��')
;
SELECT * FROM BOOK
 WHERE PUBLISHER <> '�½�����' AND PUBLISHER <> '���ѹ̵��'
;
----------------------------
--IN : �ȿ� �ֳ�? (OR���� �ܼ�ȭ)
--(�ǽ�)���ǻ� : ������, ���ѹ̵��, �Ｚ�� ���� ������ å ��ȸ
SELECT * FROM BOOK
 WHERE PUBLISHER = '������' OR PUBLISHER = '���ѹ̵��'
    OR PUBLISHER = '�Ｚ��'
;
SELECT * FROM BOOK
 WHERE PUBLISHER IN ('������', '���ѹ̵��', '�Ｚ��');
--(�ǽ�)���ǻ� : ������, ���ѹ̵��, �Ｚ���� ������ ���ǻ��� å ��ȸ
SELECT * FROM BOOK
 WHERE PUBLISHER <> '������' AND PUBLISHER <> '���ѹ̵��'
   AND PUBLISHER <> '�Ｚ��'
;
SELECT * FROM BOOK
 WHERE PUBLISHER NOT IN ('������', '���ѹ̵��', '�Ｚ��');
-------------------
-- ����(=),ũ��(>),�۴�(<),ũ�ų�����(>=),�۰ų�����(<=)
-- �����ʴ�/�ٸ���(<>, !=)
--���ǵ� å�߿� 8000�� �̻��̰� 22000�� ������ å(���ݼ����� ����)
SELECT * FROM BOOK
 WHERE PRICE >= 8000 AND PRICE <= 22000
 ORDER BY PRICE;

--BETEEN ��1 AND ��2 : ��1 ���� ��2 ���� ���·� ���
SELECT * FROM BOOK
 WHERE PRICE BETWEEN 8000 AND 22000 --��谪 ����
 ORDER BY PRICE;

--NOT BETWEEN ��1(����) AND ��2(����)
SELECT * FROM BOOK
 WHERE PRICE NOT BETWEEN 8000 AND 22000 --��谪 ���� ����
 ORDER BY PRICE;

--å������ '�߱�' ~ '�ø���'
SELECT * FROM BOOK
 WHERE BOOKNAME BETWEEN '�߱�' AND '�ø���'
 ORDER BY BOOKNAME;

--���ǻ� ������~�Ｚ�� å ��ȸ
SELECT * FROM BOOK
 WHERE PUBLISHER BETWEEN '������' AND '�Ｚ��'
 ORDER BY PUBLISHER;
----------------------------------------------
-- LIKE : '%', '_' ��ȣ�� �Բ� ���
-- % : ��ü(����)�� �ǹ�
-- _(�����) : �����ϳ��� ���Ͽ� ��� ���� �ǹ�
-------
--���ǻ�� '�̵��'��� �ܾ �ִ� ���ǻ翡�� ������ å ��ü ��ȸ
SELECT * FROM BOOK
 WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��')
;
SELECT * FROM BOOK
 WHERE PUBLISHER LIKE '%�̵��'; --���ǻ���� '�̵��'�� ������ ��

SELECT * FROM BOOK
 WHERE BOOKNAME LIKE '�߱�%'; --å������ '�߱�'�� �����ϴ� ��

SELECT * FROM BOOK
 WHERE BOOKNAME LIKE '%�ܰ�%'; --å���� '�ܰ�' �ܾ �ִ� ��
-----
--å ���� '��' ���ڰ� �ִ� å ��� ��ȸ
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%��%';

--å ������ �ι�° ���ڰ� '��'�� å ��� ��ȸ
--UPDATE BOOK SET BOOKNAME = '�츮 �߱��� �߾�' WHERE BOOKID=7;
SELECT * FROM BOOK WHERE BOOKNAME LIKE '_��%';

--å ������ 2,3��° ���ڰ� '����'�� å ��� ��ȸ
SELECT * FROM BOOK WHERE BOOKNAME LIKE '_����%';
--------------------------------------------------
--======================================
--�׷� �Լ� : �ϳ� �̻��� ���� �׷����� ��� ����
--COUNT(*) : ����Ÿ ���� ��ȸ(��ü �÷��� ���Ͽ�)
--COUNT(�÷���) : ����Ÿ ���� ��ȸ(������ �÷��� ���Ͽ�)
--SUM(�÷�) : �հ� �� ���ϱ�
--AVG(�÷�) : ��� �� ���ϱ�
--MAX(�÷�) : �ִ� �� ���ϱ�
--MIN(�÷�) : �ּ� �� ���ϱ�
---------------
SELECT COUNT(*) FROM BOOK; --BOOK ���̺��� ����Ÿ �Ǽ� 
SELECT * FROM BOOK;

SELECT * FROM CUSTOMER; --����Ÿ 5�� ��ȸ
SELECT COUNT(*) FROM CUSTOMER; --5 ��ȸ
SELECT COUNT(NAME) FROM CUSTOMER; --5 ��ȸ
SELECT COUNT(PHONE) FROM CUSTOMER; --4�� ��ȸ : NULL ���� �������� ���ܵ� 
---
--SUM(�÷�) : �÷��� �հ� �� ���� ��
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500
SELECT SUM(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��'); --90000

--AVG(�÷�) : �÷��� ��� �� ���� ��
SELECT * FROM BOOK;
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT AVG(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��');

--MAX(�÷�) : �÷��� ���߿� ���� ū �� ��ȸ
--MIN(�÷�) : �÷��� ���߿� ���� ���� �� ��ȸ
SELECT * FROM BOOK ORDER BY PRICE DESC;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK
 WHERE PUBLISHER = '�½�����'
;
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
  FROM BOOK;
--------------------------------
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID: 1
SELECT * FROM ORDERS;
--(�ǽ�)
--1. �������� �ѱ��ž�(�������� ����ȣ(CUSTID = 1))
SELECT '������', SUM(SALEPRICE) FROM ORDERS
 WHERE CUSTID = 1; --������

--2. �������� ������ ������ ��(COUNT)
SELECT '������', COUNT(*) FROM ORDERS
 WHERE CUSTID = 1;

--3. ���� '��'���� ���� �̸��� �ּ�
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '��%';

--4. ���� '��'���̰� �̸��� '��'�� ������ ���� �̸��� �ּ�
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '��%��';
---------------------------------
-- LIKE �˾ƺ���
CREATE TABLE TEST_LIKE (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO TEST_LIKE (ID,NAME) VALUES (1, 'ȫ�浿');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (2, 'ȫ�浿2');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (3, 'ȫ�浿��');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (4, 'ȫ�浿�빮');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (5, 'ȫ�浿2��');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (6, '��ȫ�浿');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (7, '�踸ȫ�浿');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (8, '��ȫ�浿��');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (9, '��ȫ�浿���̴�');
COMMIT;

SELECT * FROM TEST_LIKE;
SELECT * FROM TEST_LIKE WHERE NAME = 'ȫ�浿';
SELECT * FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿';
SELECT * FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿2%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '%ȫ�浿%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_ȫ�浿_';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_ȫ�浿%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_ȫ�浿_%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '__ȫ�浿%';




