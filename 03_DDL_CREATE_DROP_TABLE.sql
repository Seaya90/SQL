/* (�ǽ�) ���̺�� : TEST2
    NO : ����Ÿ�� 5�ڸ�, PRIMARY KEY ����
    ID : ����Ÿ�� 10�ڸ�(����10�ڸ�), ���� �ݵ�� ����
    NAME : �ѱ� 10�ڸ� ���尡����� ����, ���� �ݵ�� ����
    EMAIL : ����, ����, Ư������ ���� 30�ڸ� 
    ADDRESS : �ѱ� 100�ڸ�
    IDNUM : ����Ÿ�� ������ 7�ڸ�, �Ҽ��� 3�ڸ�(1234567.789)
    REGDATE : ��¥Ÿ��
*****************************/
CREATE TABLE TEST2 (
    NO NUMBER(5) PRIMARY KEY,
    ID VARCHAR2(10) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30),
    ADDRESS VARCHAR2(300),
    IDNUM NUMBER(10,3),
    REGDATE DATE
);
-------------
INSERT INTO TEST2
VALUES (22222, 'TEST2', 'ȫ�浿', 'test@test.com',
        '����� ���α�', 1234567.6789, sysdate);
SELECT * FROM TEST2;




