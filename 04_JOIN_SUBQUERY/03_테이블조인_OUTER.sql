--번외문제: 고객테이블에 있는 사람중 책을 구입하지 않은 사람은 누구?
--CUSTOMER 테이블에 있고, ORDERS 테이블에 없는 사람 찾기
-----------------------------
--MINUS : 교집합 처리
SELECT CUSTID
  FROM CUSTOMER
MINUS
SELECT CUSTID
  FROM ORDERS
;
-----
--서브쿼리(subquery)
SELECT CUSTID, NAME
  FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--------
--외부조인(OUTER JOIN)
SELECT C.CUSTID, C.NAME
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;
-- =============================================
--내부조인(INNER JOIN, 동등조인) : 조인테이블 모두에 존재하는 데이타 검색
--외부조인(OUTER JOIN) : 어느 한쪽 테이블에 데이타가 존재하지 않아도
---- 모두 데이타를 표시하여 일치하지 않는 데이타에 대한 조회처리 할 때 사용
CREATE TABLE DEPT (
    ID VARCHAR2(10) primary key,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES('10', '총무부');
INSERT INTO DEPT VALUES('20', '급여부');
INSERT INTO DEPT VALUES('30', '전산부');
COMMIT;
SELECT * FROM DEPT;
---------------
CREATE TABLE DEPT1 (
    ID VARCHAR2(10) primary key,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT1 VALUES('10', '총무부');
INSERT INTO DEPT1 VALUES('20', '급여부');
COMMIT;
SELECT * FROM DEPT1;
-------------------
CREATE TABLE DEPT2 (
    ID VARCHAR2(10) primary key,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT2 VALUES('10', '총무부');
INSERT INTO DEPT2 VALUES('30', '전산부');
COMMIT;
SELECT * FROM DEPT2;
---------------------------
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
SELECT * FROM DEPT2;
--DEPT1 = DEPT2
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID
; 
------------------
--ANSI : 표준SQL
SELECT *
  FROM DEPT1 D1 INNER JOIN DEPT2 D2 --조인대상 테이블
       ON D1.ID = D2.ID --조인 조건
;       

--DEPT1에는 있고 DEPT2에는 없는 부서
--LEFT OUTER JOIN : 좌측 테이블 기준 전체 표시하고 우측에 없으면 NULL표시
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+) --DEPT2 테이블에 없으면 NULL표시
;
------
--ANSI SQL
SELECT *
  FROM DEPT1 D1 LEFT OUTER JOIN DEPT2 D2 --조인테이블 및 방식
       ON D1.ID = D2.ID --조인조건
;       

SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+) --DEPT2 테이블에 없으면 NULL표시
   AND D2.ID IS NULL --좌측에만 있는 데이타 조회(우측테이블 NULL인 데이타)
;
-------------------------
--RIGHT OUTER JOIN : 우측 테이블 기준 전체 표시하고 좌측에 없으면 NULL표시
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID(+) = D2.ID --조인조건 : 우측 테이블 기준
;
--ANSI SQL
SELECT *
  FROM DEPT1 D1 RIGHT OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;
--LEFT OUTER JOIN
SELECT *
  FROM DEPT2 D2, DEPT1 D1
 WHERE D2.ID = D1.ID(+)
;
-------------------------------
--FULL OUTER JOIN : 양쪽 테이블에 있는 데이타를 모두 표시
--ANSI 표준 FULL OUTER JOIN 문 사용
SELECT D1.ID D1_ID, D1.NAME D1_NAME,
       D2.ID D2_ID, D2.NAME D2_NAME
  FROM DEPT1 D1 FULL OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;
---------------



