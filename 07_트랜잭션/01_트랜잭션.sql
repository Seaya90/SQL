/***** Ʈ�����(TRANSACTION) *******
Ʈ�����(TRANSACTION) : DBMS���� ����Ÿ�� �ٷ�� ������ �۾��� ����

<Ʈ������� ����>
COMMIT : �۾� ������ DB�� �ݿ��ϰ� Ʈ����� ����

<Ʈ����� �Ϻ� �Ǵ� ��ü ��ȿȭ>
ROLLBACK; --���� COMMIT �������� ��� ���
ROLLBACK TO ���̺�����Ʈ�̸�; --���̺�����Ʈ��ġ���� ���

<���̺�����Ʈ ����>
SAVEPOINT ���̺�����Ʈ�̸�;
**********************************/
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
INSERT INTO DEPT1 VALUES ('40', '�λ��');
COMMIT; --������ SAVEPOINT ������
---
SELECT * FROM DEPT;
SELECT * FROM DEPT1;

--DEPT1 ���̺��� ID: 40 ����Ÿ ����
DELETE FROM DEPT1 WHERE ID = '40';
SELECT * FROM DEPT1;

--���̺�����Ʈ ���� : S1
SAVEPOINT S1;

-->>���� ID: 20
DELETE FROM DEPT1 WHERE ID = '20';
SELECT * FROM DEPT1;

--���̺�����Ʈ ���� : S2
SAVEPOINT S2;

-->>���� ID: 10
DELETE FROM DEPT1 WHERE ID = '10';
SELECT * FROM DEPT1;

-------------------
--Ʈ����� �ǵ�����(ROLLBACK)
--ROLLBACK; --���� COMMIT �������� �ǵ�����
--ROLLBACK TO ���̺�����Ʈ; --���̺�����Ʈ �������� ROLLBACK;
SELECT * FROM DEPT1;

--S2���� ROLLBACK
ROLLBACK TO S2;
SELECT * FROM DEPT1; --10	�ѹ��� ������(�ǵ����� ROLLBACK)

--S1���� ROLLBACK
ROLLBACK TO S1;
SELECT * FROM DEPT1; --20	�޿��� �����۾� ROLLBACK ó����

--���� COMMIT �������� ROLLBACK
ROLLBACK;
SELECT * FROM DEPT1;

