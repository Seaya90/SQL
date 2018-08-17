/* ** �ǽ����� : HR����(DB)���� �䱸���� �ذ� **********
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
-- ������ �ִ� ���޿� �˻�
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
-- ������ ��ձ޿� �̻��� ���� ��ȸ
**********************************************************/
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
SELECT * FROM EMPLOYEES WHERE SALARY >=15000;

-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY 
  FROM EMPLOYEES WHERE SALARY >=15000;

-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY 
  FROM EMPLOYEES WHERE SALARY <= 10000
ORDER BY SALARY DESC  
;

-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME = 'John';
--John, JOHN, john
SELECT *
--SELECT FIRST_NAME, LOWER(FIRST_NAME)
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = 'john';

-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
SELECT COUNT(*)
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = 'john';

-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD')
                    AND TO_DATE('2008-12-31', 'YYYY-MM-DD')
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2008'
;

-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000;

-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
SELECT * FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
SELECT MAX(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- ������(���� ���� ��Ƽ�/�׷����� ����) �ִ� ���޿� �˻�
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
 ORDER BY MAX(SALARY) DESC
;
-----------------------------------------
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
 WHERE SALARY >= 10000
 GROUP BY JOB_ID
;
---
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
 HAVING MAX(SALARY) >= 10000
;
------------------------------------
-- ������ ��ձ޿� �̻��� ���� ��ȸ
SELECT *
  FROM EMPLOYEES E,
       (SELECT JOB_ID, AVG(SALARY) AVG_SALARY
          FROM EMPLOYEES
         GROUP BY JOB_ID
       ) AVG
 WHERE E.JOB_ID = AVG.JOB_ID
   AND E.SALARY >= AVG.AVG_SALARY
;
--- SUB QUERY ó��
SELECT * 
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY >= (SELECT AVG(SALARY) 
                        FROM EMPLOYEES E
                       WHERE EMP.JOB_ID = E.JOB_ID
                     )
;
--------------------------
--(�߰�) ������ �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, ����(����)�ڵ� ���� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY, JOB_ID
  FROM EMPLOYEES E
 WHERE E.SALARY = (SELECT MAX(SALARY) 
                   FROM EMPLOYEES
                   WHERE JOB_ID = E.JOB_ID)
ORDER BY SALARY DESC;                   

-- �� ����
/*
SELECT JOB_ID, SALARY, EMPLOYEE_ID 
FROM EMPLOYEES 
WHERE JOB_ID = 'FI_ACCOUNT'
ORDER BY SALARY DESC; --109	Daniel Faviet	9000	FI_ACCOUNT
*/
----------
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       E.JOB_ID, SALARY, MAX_SALARY
  FROM EMPLOYEES E
     , (SELECT JOB_ID, MAX(SALARY) MAX_SALARY
        FROM EMPLOYEES
        GROUP BY JOB_ID
       ) MAX
 WHERE E.JOB_ID = MAX.JOB_ID
   AND E.SALARY = MAX.MAX_SALARY
ORDER BY SALARY DESC;      

--(�߰�) �μ��� �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, �μ��ڵ� ���� ��ȸ
--��� �������� ���
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY, DEPARTMENT_ID
  FROM EMPLOYEES E
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
                  GROUP BY DEPARTMENT_ID)
;
-----
--JOIN������
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY, E.DEPARTMENT_ID,
       MAX.MAX_SALARY
  FROM EMPLOYEES E
     , (SELECT DEPARTMENT_ID, MAX(SALARY) MAX_SALARY
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID
       ) MAX
 WHERE E.DEPARTMENT_ID = MAX.DEPARTMENT_ID
   AND E.SALARY = MAX.MAX_SALARY
;   
--=========================================
SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID
FROM EMPLOYEES;
--101	Neena	100(MANAGER_ID)
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;
--100	Steven	King
--�������� �Ŵ����� �̸��� �Բ� ��ȸ
--EMPLOYEE_ID, FIRST_NAME, MANAGER_ID, FIRST_NAME(MANAGER)
--101	Neena              100	Steven	King
-----
SELECT EMPLOYEE_ID, FIRST_NAME, 
       MANAGER_ID, 
       '�Ŵ��� �̸�'
  FROM EMPLOYEES;
-----------------
--SELF JOIN ������ �ۼ�
SELECT E1.EMPLOYEE_ID, E1.FIRST_NAME, 
       E1.MANAGER_ID, 
       E2.EMPLOYEE_ID, E2.FIRST_NAME
  FROM EMPLOYEES E1,
       EMPLOYEES E2
 WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID(+)
 ORDER BY E1.EMPLOYEE_ID
;

