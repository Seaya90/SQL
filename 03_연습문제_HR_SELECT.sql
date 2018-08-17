/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
-- 사번(employee_id)이 100인 직원 정보 전체 보기
-- 월급(salary)이 15000 이상인 직원의 모든 정보 보기
-- 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
-- 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
-- 이름(first_name)이 john인 사원의 모든 정보 조회
-- 이름(first_name)이 john인 사원은 몇 명인가?
-- 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
-- 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
-- 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
-- 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
-- 직종별 최대 월급여 검색
-- 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
-- 직종별 평균급여 이상인 직원 조회
**********************************************************/
-- 사번(employee_id)이 100인 직원 정보 전체 보기
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

-- 월급(salary)이 15000 이상인 직원의 모든 정보 보기
SELECT * FROM EMPLOYEES WHERE SALARY >=15000;

-- 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY 
  FROM EMPLOYEES WHERE SALARY >=15000;

-- 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY 
  FROM EMPLOYEES WHERE SALARY <= 10000
ORDER BY SALARY DESC  
;

-- 이름(first_name)이 john인 사원의 모든 정보 조회
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME = 'John';
--John, JOHN, john
SELECT *
--SELECT FIRST_NAME, LOWER(FIRST_NAME)
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = 'john';

-- 이름(first_name)이 john인 사원은 몇 명인가?
SELECT COUNT(*)
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = 'john';

-- 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
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

-- 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000;

-- 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
SELECT * FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
SELECT MAX(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- 직종별(같은 직종 모아서/그룹으로 만들어서) 최대 월급여 검색
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
 ORDER BY MAX(SALARY) DESC
;
-----------------------------------------
-- 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
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
-- 직종별 평균급여 이상인 직원 조회
SELECT *
  FROM EMPLOYEES E,
       (SELECT JOB_ID, AVG(SALARY) AVG_SALARY
          FROM EMPLOYEES
         GROUP BY JOB_ID
       ) AVG
 WHERE E.JOB_ID = AVG.JOB_ID
   AND E.SALARY >= AVG.AVG_SALARY
;
--- SUB QUERY 처리
SELECT * 
  FROM EMPLOYEES EMP
 WHERE EMP.SALARY >= (SELECT AVG(SALARY) 
                        FROM EMPLOYEES E
                       WHERE EMP.JOB_ID = E.JOB_ID
                     )
;
--------------------------
--(추가) 직종별 최대 월급여를 받는 직원의 사번, 성명, 월급여, 직종(직무)코드 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY, JOB_ID
  FROM EMPLOYEES E
 WHERE E.SALARY = (SELECT MAX(SALARY) 
                   FROM EMPLOYEES
                   WHERE JOB_ID = E.JOB_ID)
ORDER BY SALARY DESC;                   

-- 값 검증
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

--(추가) 부서별 최대 월급여를 받는 직원의 사번, 성명, 월급여, 부서코드 정보 조회
--상관 서브쿼리 방식
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULL_NAME,
       SALARY, DEPARTMENT_ID
  FROM EMPLOYEES E
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
                  GROUP BY DEPARTMENT_ID)
;
-----
--JOIN문으로
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
--직원들의 매니저의 이름을 함께 조회
--EMPLOYEE_ID, FIRST_NAME, MANAGER_ID, FIRST_NAME(MANAGER)
--101	Neena              100	Steven	King
-----
SELECT EMPLOYEE_ID, FIRST_NAME, 
       MANAGER_ID, 
       '매니저 이름'
  FROM EMPLOYEES;
-----------------
--SELF JOIN 문으로 작성
SELECT E1.EMPLOYEE_ID, E1.FIRST_NAME, 
       E1.MANAGER_ID, 
       E2.EMPLOYEE_ID, E2.FIRST_NAME
  FROM EMPLOYEES E1,
       EMPLOYEES E2
 WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID(+)
 ORDER BY E1.EMPLOYEE_ID
;

