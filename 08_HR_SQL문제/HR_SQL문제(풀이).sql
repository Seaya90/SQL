/* ***** HR DB ������ ��ȸ �ǽ� *****************/
--��1 HR �μ����� ���� �� ������ �޿� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
--  �������(Employees) ���̺��� �޿��� $7,000~$10,000 ���� �̿��� ����� 
--  �̸��� ��(Name���� ��Ī) �� �޿��� �޿��� ���� ������ ����Ͻÿ�
--------------------------------------------------------
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, SALARY
  FROM Employees
 WHERE SALARY < 7000 OR SALARY > 10000
 ORDER BY SALARY --ASC(�⺻) ��������
;
----
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, SALARY
  FROM Employees
 WHERE SALARY NOT BETWEEN 7000 AND 10000
 ORDER BY SALARY --ASC(�⺻) ��������
;
----
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, SALARY
  FROM Employees
 WHERE NOT (SALARY BETWEEN 7000 AND 10000)
 ORDER BY SALARY --ASC(�⺻) ��������
;
  
/*
��2 HR �μ������� �޿�(salary)�� ������(commission_pct)�� ���� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
  ������ �޴� ��� ����� �̸��� ��(Name���� ��Ī), �޿�, ����, �������� ����Ͻÿ�. 
  �̶� �޿��� ū ������� �����ϵ�, �޿��� ������ �������� ū ������� �����Ͻÿ�
****************************************************/
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, SALARY,
       COMMISSION_PCT
  FROM EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL
 ORDER BY SALARY DESC, COMMISSION_PCT DESC
; 
/*  
��3 �̹� �б⿡ 60�� IT �μ������� �ű� ���α׷��� �����ϰ� �����Ͽ� ȸ�翡 �����Ͽ���. 
  �̿� �ش� �μ��� ��� �޿��� 12.3% �λ��ϱ�� �Ͽ���. 
  60�� IT �μ� ����� �޿��� 12.3% �λ��Ͽ� ������(�ݿø�) ǥ���ϴ� ������ �ۼ��Ͻÿ�. 
  ������ �����ȣ, ���� �̸�(Name���� ��Ī), �޿�, �λ�� �޿�(Increase Salary�� ��Ī)������ ����Ͻÿ�
*************************************/  
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, 
       SALARY, SALARY * 0.123, ROUND(SALARY * 1.123) AS "Increase Salary"
  FROM EMPLOYEES
 WHERE department_id = 60
; 


/*
��4 �� ����� ��(last_name)�� 's'�� ������ ����� �̸��� ������ �Ʒ��� ���� ���� ����ϰ��� �Ѵ�. 
  ��� �� �̸�(first_name)�� ��(last_name)�� ù ���ڰ� �빮��, ������ ��� �빮�ڷ� ����ϰ� 
  �Ӹ���(��ȸ�÷���)�� Employee JOBs.�� ǥ���Ͻÿ�
  ��) FIRST_NAME  LAST_NAME  Employee JOBs.
      Shelley     Higgins    AC_MGR
****************************************/
SELECT FIRST_NAME, LAST_NAME, JOB_ID AS "Employee JOBs."
  FROM EMPLOYEES
 WHERE LAST_NAME LIKE '%s'
;
----
--���ĺ� ���� : UPPER, LOWER, INITCAP �Լ�
SELECT UPPER(FIRST_NAME), INITCAP(UPPER(FIRST_NAME)), 
       LOWER(LAST_NAME), INITCAP(LOWER(LAST_NAME)), 
       JOB_ID AS "Employee JOBs."
  FROM EMPLOYEES
 WHERE LAST_NAME LIKE '%s'
;

/*
��5 ��� ����� ������ ǥ���ϴ� ������ �ۼ��Ϸ��� �Ѵ�. 
  ������ ����� �̸��� ��(Name���� ��Ī), �޿�, ���翩�ο� ���� ������ �����Ͽ� ����Ͻÿ�. 
  ���翩�δ� ������ ������ "Salary + Commission", ������ ������ "Salary only"��� ǥ���ϰ�, 
  ��Ī�� ������ ���̽ÿ�. ���� ��� �� ������ ���� ������ �����Ͻÿ�
****************************************/
SELECT FIRST_NAME||' '||LAST_NAME AS NAME,
       SALARY, 
       SALARY * NVL(COMMISSION_PCT, 0) AS COMMISSION,
       (SALARY + SALARY * NVL(COMMISSION_PCT, 0)) * 12
       AS SALARY12,
       SALARY * (1 + NVL(COMMISSION_PCT, 0)) * 12
       AS SALARY12_2,
       COMMISSION_PCT,
       DECODE(COMMISSION_PCT, NULL, 'Salary only', 'Salary + Commission')
       AS COMMISSION_YN
  FROM EMPLOYEES
 ORDER BY SALARY12 DESC
;

/*  
��6 �� ����� �Ҽӵ� �μ����� �޿� �հ�, �޿� ���, �޿� �ִ�, �޿� �ּڰ��� �����ϰ��� �Ѵ�. 
  ���� ��°��� ���� �ڸ��� �� �ڸ� ���б�ȣ(�޸�), $ǥ�ÿ� �Բ� ���($123,456) 
  ��, �μ��� �Ҽӵ��� ���� ����� ���� ������ �����ϰ�, 
  ��� �� �Ӹ����� ��Ī(alias) ó���Ͻÿ�
********************************/    
SELECT DEPARTMENT_ID
     , COUNT(*) AS "�μ��ο�"
     , TO_CHAR(SUM(SALARY), '$999,999') AS "�޿��հ�"
     , TO_CHAR(SUM(SALARY), '$000,000') AS "�޿��հ�2"
     , ROUND(AVG(SALARY), 2) "�޿����"
     , TO_CHAR(ROUND(AVG(SALARY), 2), '$999,999.99') "�޿����2"
     , TO_CHAR(MAX(SALARY), '$999,999') "�޿��ִ밪"
     , TO_CHAR(MIN(SALARY), '$999,999') "�޿��ּҰ�"
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NOT NULL
 GROUP BY DEPARTMENT_ID
 ORDER BY 3 DESC
;

/*
��7 ������� ������ ��ü �޿� ����� $10,000���� ū ��츦 ��ȸ�Ͽ� ������ �޿� ����� ����Ͻÿ�. 
  �� ������ CLERK�� ���Ե� ���� �����ϰ� ��ü �޿� ����� ���� ������� ����Ͻÿ�
*********************************/
SELECT DISTINCT JOB_ID FROM EMPLOYEES;
SELECT JOB_ID FROM EMPLOYEES GROUP BY JOB_ID;

SELECT JOB_ID, AVG(SALARY)
  FROM EMPLOYEES
 WHERE JOB_ID NOT LIKE '%CLERK%'
 GROUP BY JOB_ID
 HAVING AVG(SALARY) >= 10000
;
/*
��8 HR ��Ű���� �����ϴ� Employees, Departments, Locations ���̺��� ������ �ľ��� �� 
  Oxford�� �ٹ��ϴ� ����� �̸��� ��(Name���� ��Ī), ����, �μ��̸�, �����̸��� ����Ͻÿ�. 
  �̶� ù ��° ���� ȸ���̸��� 'HR-Company'�̶�� ������� ��µǵ��� �Ͻÿ�
*****************************/
SELECT 'HR-Company' AS COMPANY_NAME, 
       FIRST_NAME ||' '|| LAST_NAME AS NAME,
       JOB_ID,
       E.DEPARTMENT_ID,
       d.department_name,
       L.CITY
  FROM EMPLOYEES E, departments D, LOCATIONS L
 WHERE E.DEPARTMENT_ID = d.department_id --��������
   AND d.location_id = l.location_id --��������
   AND L.CITY = 'Oxford'
;
------------------------
SELECT 'HR-Company' AS COMPANY_NAME, 
       FIRST_NAME ||' '|| LAST_NAME AS NAME,
       JOB_ID,
       DEPARTMENT_ID,
       department_name,
       CITY
  FROM EMP_DETAILS_VIEW
 WHERE CITY = 'Oxford'
;

/*
��9 HR ��Ű���� �ִ� Employees, Departments ���̺��� ������ �ľ��� �� ������� �ټ� �� �̻��� 
  �μ��� �μ��̸��� ��� ���� ����Ͻÿ�. �̶� ��� ���� ���� ������ �����Ͻÿ�


��10 �� ����� �޿��� ���� �޿� ����� �����Ϸ��� �Ѵ�. 
  �޿� ����� Job_Grades ���̺� ǥ�õȴ�. �ش� ���̺��� ������ ���캻 �� 
  ����� �̸��� ��(Name���� ��Ī), ����, �μ��̸�, �Ի���, �޿�, �޿������ ����Ͻÿ�.
  
CREATE TABLE JOB_GRADES (
    GRADE_LEVEL VARCHAR2(3),
    LOWEST_SAL NUMBER,
    HIGHEST_SAL NUMBER
);
INSERT INTO JOB_GRADES VALUES ('A', 1000, 2999);
INSERT INTO JOB_GRADES VALUES ('B', 3000, 5999);
INSERT INTO JOB_GRADES VALUES ('C', 6000, 9999);
INSERT INTO JOB_GRADES VALUES ('D', 10000, 14999);
INSERT INTO JOB_GRADES VALUES ('E', 15000, 24999);
INSERT INTO JOB_GRADES VALUES ('F', 25000, 40000);
COMMIT;

********************************/
