/* ************************
SELECT [* | DISTINCT ]{컬럼명,컬럼명,...}
  FROM 테이블명
[WHERE 조건절]
[GROUP BY {컬럼명,...}]
[HAVING 조건]  --GROUP BY 절에 대한 조건
[ORDER BY {컬럼명 [ASC | DESC],... }] --ASC : 오름차순(기본/생략가능)
                                     --DESC : 내림차순
***************************/
--GROUP BY : 데이타를 그룹핑해서 처리할 경우 사용
--GROUP BY 문을 사용하면 SELECT 항목은 GROUP BY 절에 사용된 컬럼 
----또는 그룹함수(COUNT, SUM, AVG, MAX, MIN)만 사용할 수 있다
------------
--구매고객명별로 구매금액 합계를 구하시오
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
; 
--주문(판매)테이블의 고객별 데이타 조회(건수, 합계, 평균, 최소, 최대금액)
SELECT CUSTID, COUNT(*), SUM(SALEPRICE), TRUNC(AVG(SALEPRICE)),
       MIN(SALEPRICE), MAX(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
--고객명 기준으로 고객별 건수, 합계, 평균, 최소, 최대금액
SELECT CUST.NAME, 
       COUNT(*), --구입(판매)건수
       SUM(ORD.SALEPRICE), --구입(판매) 합계금액
       TRUNC(AVG(ORD.SALEPRICE)), --구입(판매) 평균금액
       MIN(ORD.SALEPRICE), --구입(판매) 가장 가격이 싼 책
       MAX(ORD.SALEPRICE) --구입(판매) 가장 가격이 비싼 책
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
 GROUP BY CUST.NAME
; 
--
SELECT CUST.NAME, 
       COUNT(*), --구입(판매)건수
       SUM(ORD.SALEPRICE), --구입(판매) 합계금액
       TRUNC(AVG(ORD.SALEPRICE)), --구입(판매) 평균금액
       MIN(ORD.SALEPRICE), --구입(판매) 가장 가격이 싼 책
       MAX(ORD.SALEPRICE) --구입(판매) 가장 가격이 비싼 책
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
   AND CUST.NAME IN ('추신수', '장미란')
 GROUP BY CUST.NAME
;  
----------------------
--HAVING절 : GROUP BY 에 의해 만들어진 데이타에서 검색조건을 부여
--HAVING절은 단독으로 쓰일 수 없고 GROUP BY 절과 함께 사용
SELECT CUST.NAME, 
       COUNT(*), --구입(판매)건수
       SUM(ORD.SALEPRICE), --구입(판매) 합계금액
       TRUNC(AVG(ORD.SALEPRICE)), --구입(판매) 평균금액
       MIN(ORD.SALEPRICE), --구입(판매) 가장 가격이 싼 책
       MAX(ORD.SALEPRICE) --구입(판매) 가장 가격이 비싼 책
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
 GROUP BY CUST.NAME
 HAVING COUNT(*) >=3
;
--
SELECT CUST.NAME, 
       COUNT(*), --구입(판매)건수
       SUM(ORD.SALEPRICE), --구입(판매) 합계금액
       TRUNC(AVG(ORD.SALEPRICE)), --구입(판매) 평균금액
       MIN(ORD.SALEPRICE), --구입(판매) 가장 가격이 싼 책
       MAX(ORD.SALEPRICE) --구입(판매) 가장 가격이 비싼 책
  FROM ORDERS ORD, CUSTOMER CUST
 WHERE ORD.CUSTID = CUST.CUSTID
 GROUP BY CUST.NAME
 HAVING MAX(ORD.SALEPRICE) >= 20000
;
----
-- 판매(구입)가격이 8000원 이상인 도서를 구매한 고객 대상으로
-- 고객별 도서의 총수량을 구하시오(단 2권 이상 구매한 사람만) 
SELECT CUSTID, COUNT(*)
  FROM ORDERS
 WHERE SALEPRICE >= 8000 --판매(구입) 금액이 8000원 이상 금액
 GROUP BY CUSTID --고객별(그룹)
 HAVING COUNT(*) >= 2 --판매(구매)건수가 2권 이상인 
;
--구매자 이름 확인
SELECT C.NAME, COUNT(*)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND SALEPRICE >= 8000 --판매(구입) 금액이 8000원 이상 금액
 GROUP BY O.CUSTID, C.NAME --고객별(그룹)
 HAVING COUNT(*) >= 2 --판매(구매)건수가 2권 이상인 
;
----------------------------
--실습 문제
--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
--2. 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬하시오.
--5. 고객별로 주문한 건수와 합계금액, 평균 금액을 구하고 
---- (3권 보다 적게 구입한 사람 검색)
--번외문제: 고객테이블에 있는 사람중 책을 구입하지 않은 사람은 누구?
---------------
--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
SELECT COUNT(*) AS "TOTAL COUNT",
       SUM(SALEPRICE) AS "판매액 합계",
       AVG(SALEPRICE) "평균값", --AS 생략 가능
       MIN(SALEPRICE) "최저가",
       MAX(SALEPRICE) "최고가"
  FROM ORDERS
;
--2. 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 ORDER BY SUM(O.SALEPRICE) DESC --가장 많은 금액 구매자순으로 정렬
; 

--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT C.NAME, O.SALEPRICE
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
;

--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬하시오.
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;

--5. 고객별로 주문한 건수와 합계금액, 평균 금액을 구하고 
---- (3권 보다 적게 구입한 사람 검색)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), TRUNC(AVG(O.SALEPRICE))
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) < 3
;

--번외문제: 고객테이블에 있는 사람중 책을 구입하지 않은 사람은 누구?





  
  
  
  
  
  