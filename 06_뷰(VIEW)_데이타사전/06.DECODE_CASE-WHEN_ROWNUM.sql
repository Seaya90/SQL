SELECT * FROM BOOK;

--ROWNUM : ����Ŭ���� �����ϴ� <������ ROW ��ȣ> �÷�
--����Ÿ�� ��ȸ������ ���� �������� ���
SELECT ROWNUM, B.* FROM BOOK B WHERE ROWNUM <= 5;
SELECT ROWNUM, B.* FROM BOOK B
 ORDER BY PRICE; --���Ľ� ROWNUM�� 1~N �������� ������ ����

--ROWNUM�� �׻� 1~N ���·� �����Ϸ��� 
--ORDER BY ���� �� ROWNUM ��ȸ
SELECT ROWNUM, B.*
  FROM (SELECT * FROM BOOK
        ORDER BY PRICE
       ) B
 WHERE ROWNUM <= 5
; 

SELECT *
  FROM (SELECT ROWNUM RNO, B.*
          FROM (SELECT * FROM BOOK
                ORDER BY PRICE
               ) B
       )
 WHERE RNO BETWEEN 6 AND 10    
; 
--=======================================
/********************
DECODE, CASE : SQL�� ������ IF�� ����
DECODE : ����Ŭ�� �����Ǵ� DB������ ��밡��
CASE : ANSI ǥ������ ��� DB���� ��밡��(��, �������ϸ� ������)
*********************/
/*** DECODE �Լ�
DECODE �Լ��� ����񱳸� ����
DECODE(���, �񱳰�, ���=�񱳰� ��� ó����, ���<>�񱳰��� ���ó����);
DECODE(���, �񱳰�, DECODE(), DECODE());
DECODE(���, �񱳰�1, ó����1
          , �񱳰�2, ó����2 
          ... 
          , �񱳰�n, ó����n
          , ó����n+1);
*****************************/
SELECT * FROM CUSTOMER ORDER BY NAME;

--�̸��� �迬�Ƹ� '��~ �迬�ƴ�!!!' �ƴϸ� '��������?' ���
SELECT NAME, 
       DECODE(NAME, '�迬��', '��~ �迬�ƴ�!!!', '��������?')
  FROM CUSTOMER
 ORDER BY NAME;

--�̸��� �������̸� '�౸����', �ƴϸ� '�����'
SELECT NAME, 
       DECODE(NAME, '������', '�౸����', '�����')
  FROM CUSTOMER
 ORDER BY NAME;
---------------
--�̸��� �迬�Ƹ� '�ǰܽ�������', �ڼ����� '����', �������̸� '�౸����'
--������ '�����'
--IF(){} ELSE IF(){} ELSE IF(){}.. ELSE {}
--DECODE(NAME,'�迬��','�ǰܽ�������','�ڼ���','����','������','�౸����','�����')
SELECT NAME,
       DECODE(NAME, '�迬��', '�ǰܽ�������',
                    '�ڼ���', '����',
                    '������', '�౸����',
                    '�����')
  FROM CUSTOMER
 ORDER BY NAME;
---------------
--DECODE���� TRUE, FALSE ó���� DECODE�� ��� ����
SELECT NAME,
       DECODE(NAME, '�迬��', '�迬�ƴ�',
                    DECODE(NAME, '�ڼ���', '�ڼ�����',
                                 DECODE(NAME, '������', '�������̴�','�߸𸣰ڴ�')  
                          ) 
             )
  FROM CUSTOMER
 ORDER BY NAME;

--===============================================
/***** CASE �� ************
����1 : SWITCH CASEó��(DECODE�� ó��)
CASE �÷�(���ذ�)
     WHEN �񱳰�1 THEN ��ġ�ϸ� ó���� ����
     WHEN �񱳰�2 THEN ��ġ�ϸ� ó���� ����
     ...
     WHEN �񱳰�n THEN ��ġ�ϸ� ó���� ����
     ELSE ���� ��ġ�ϴ� ��찡 ������ ������ ����
END
--------
����2 : IF THEN ELSE ó�� ���(�ε�� ó�� ����)
--CASE�� ���� ó�����忡�� CASE�ߺ� ��� ����
--�񱳱��� : =, <>, !=, >, <, >=, <=, AND, OR, NOT ��밡��
CASE WHEN �񱳱���
     THEN �񱳱��� ��� TRUE�� ��� ó������
     ELSE �񱳱��� ��� FALSE�� ��� ó������
END   

CASE WHEN �񱳱���(��: KOR > 90)
     THEN (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
     ELSE (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
END   

CASE WHEN �񱳱��� THEN ó������
     WHEN �񱳱��� THEN ó������
     ....
     ELSE ���� �񱳱����� �ش���� �ʴ� ��� ó������
END 
***************************/
SELECT * FROM CUSTOMER ORDER BY NAME;
--�̸��� �������̸� '�౸����' �ƴϸ� '�����' ���
SELECT NAME,
       CASE NAME WHEN '������' THEN '�౸����' ELSE '�����' END           
  FROM CUSTOMER
 ORDER BY NAME;
--
SELECT NAME,
       CASE NAME WHEN '������' 
                 THEN '�౸����' 
                 ELSE '�����' 
       END           
  FROM CUSTOMER
 ORDER BY NAME;
-------------------
--�̸��� �迬��->�ǰܽ�������, �ڼ���->����, ������->�౸, ������ �����
SELECT NAME,
       CASE NAME
            WHEN '�迬��' THEN '�ǰܽ�������'
            WHEN '�ڼ���' THEN '����'
            WHEN '������' THEN '�౸'
            ELSE '�����'
       END 
  FROM CUSTOMER
 ORDER BY NAME;
-- DECODE��
SELECT NAME,
       DECODE(NAME, '�迬��', '�ǰܽ�������',
                    '�ڼ���', '����',
                    '������', '�౸����',
                    '�����')
  FROM CUSTOMER
 ORDER BY NAME;
--------------------------------
--BOOK ���̺��� ������ �̿��� �� ó��
SELECT * FROM BOOK ORDER BY PRICE;
----------
--����(PRICE)�� 10000 �̸��̸� '�δ�', 10000 ~ 20000: '�����ϴ�'
--20000���� ũ�� '��δ�', 30000 ���� ũ�� '�ʹ���δ�'
SELECT B.*,
       CASE WHEN PRICE < 10000 
            THEN '�δ�'
            ELSE CASE WHEN PRICE <= 20000
                      THEN '�����ϴ�'
                      ELSE CASE WHEN PRICE <= 30000
                                THEN '��δ�'
                                ELSE '�ʹ���δ�'
                           END
                 END
       END AS "������"
  FROM BOOK B
 ORDER BY PRICE;
--------------
--�߰���û���� �߻� : 7000���� ������ '�����̳�' �߰�
SELECT B.*,
       CASE WHEN PRICE < 7000
            THEN '�����̳�'
            ELSE
               CASE WHEN PRICE < 10000 
                    THEN '�δ�'
                    ELSE CASE WHEN PRICE <= 20000
                              THEN '�����ϴ�'
                              ELSE CASE WHEN PRICE <= 30000
                                        THEN '��δ�'
                                        ELSE '�ʹ���δ�'
                                   END
                         END
               END
       END 
  FROM BOOK B
 ORDER BY PRICE;
----
SELECT B.*,
       CASE WHEN PRICE < 10000 
            THEN CASE WHEN PRICE < 7000
                      THEN '�����̳�'
                      ELSE '�δ�'
                 END   
            ELSE CASE WHEN PRICE <= 20000
                      THEN '�����ϴ�'
                      ELSE CASE WHEN PRICE <= 30000
                                THEN '��δ�'
                                ELSE '�ʹ���δ�'
                           END
                 END
       END AS "������"
  FROM BOOK B
 ORDER BY PRICE;
-------------------------- 
SELECT B.*,
       CASE WHEN PRICE < 7000 THEN '�����̳�'
            WHEN PRICE < 10000 THEN '�δ�'
            WHEN PRICE <= 20000 THEN '�����ϴ�'
            WHEN PRICE <= 30000 THEN '��δ�'
            ELSE '�ʹ���δ�'
       END
  FROM BOOK B
 ORDER BY PRICE;

