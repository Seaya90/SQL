SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
-------------------------
--박지성이 구입한 금액합계
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --ID: 1
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT '박지성' AS NAME, SUM(SALEPRICE) 
  FROM ORDERS WHERE CUSTID = 1;
----------------
--서브쿼리(subquery) 방식
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --ID: 1
SELECT * FROM ORDERS 
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');
------------------
--테이블 조인(join) 방식
SELECT * FROM CUSTOMER WHERE CUSTID = 1;
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT *
  FROM CUSTOMER, ORDERS --조인할 테이블 
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인할 조건
;
--------
SELECT CUSTOMER.CUSTID, CUSTOMER.NAME, CUSTOMER.ADDRESS,
       ORDERS.SALEPRICE, ORDERS.ORDERDATE 
  FROM CUSTOMER, ORDERS
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
;
-------
--테이블명.컬럼명 사용으로 테이블 컬럼 데이타 조회
SELECT CUSTOMER.CUSTID, CUSTOMER.NAME, CUSTOMER.ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, ORDERS.SALEPRICE, ORDERS.ORDERDATE 
  FROM CUSTOMER, ORDERS
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인조건(테이블 결합시 사용)
   AND CUSTOMER.NAME = '박지성' --검색 조건(WHERE)
;
------
--컬럼명이 조인 테이블내에서 유일(unique)하면 테이블 지정 생략 가능
SELECT CUSTOMER.CUSTID, NAME, ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, SALEPRICE, ORDERDATE 
  FROM CUSTOMER, ORDERS
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인조건(테이블 결합시 사용)
   AND NAME = '박지성' --검색 조건(WHERE)
;
--------------------
--별칭(alias)사용으로 단순화
SELECT c.CUSTID, c.NAME, c.ADDRESS, c.PHONE,
       o.CUSTID AS ORD_CUSTID, o.SALEPRICE, o.ORDERDATE 
  FROM CUSTOMER C, ORDERS O
 WHERE c.CUSTID = o.CUSTID --조인조건(테이블 결합시 사용)
   AND c.NAME = '박지성' --검색 조건(WHERE)
;
--------------
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
----
SELECT O.ORDERID, O.BOOKID, B.BOOKNAME, B.PRICE, B.PUBLISHER,
       O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
 ORDER BY O.ORDERID
;
----------
--/////////////////////////////////////////////
--주의: 조인 조건을 명시하지 않는 경우(카티션곱 catesian product)
--조인 대상 테이블의 각 데이타건수 * 데이타건수 결과 발생
SELECT *
  FROM BOOK B, ORDERS O
 ORDER BY B.BOOKID, O.ORDERID
;
---
SELECT *
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
 ORDER BY B.BOOKID, O.ORDERID
;
-----------------
--조인 : 3개의 테이블 조인
SELECT *
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID -- O = B
   AND O.CUSTID = C.CUSTID -- O = C
;
--
SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID -- B = O
   AND O.CUSTID = C.CUSTID -- O = C
;
-----------------------------------
--3개 테이블 조인
--고객명, 구입한 책 제목, 판매가격, 판매일자, 출판사명 
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, o.orderdate, b.publisher
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID -- O = B
   AND O.CUSTID = C.CUSTID -- O = C
;
--------------
--장미란이 구입한 책제목, 구입가격, 구입일자, 출판사
--장미란 : CUSTOMER 장미란
--구입한 : ORDERS
--책제목 : BOOK
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --조인조건
   AND C.NAME = '장미란'
;
---------------------------
--장미란이 구입한 책 중에 2014-01-01 ~ 2014-07-08까지 자료
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --조인조건
   AND C.NAME = '장미란'
   AND O.ORDERDATE BETWEEN TO_DATE('2014-01-01', 'YYYY-MM-DD')
                       AND TO_DATE('2014-07-08', 'YYYY-MM-DD')
;
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --조인조건
   AND C.NAME = '장미란'
   AND O.ORDERDATE >= TO_DATE('2014-01-01', 'YYYY-MM-DD')
   AND O.ORDERDATE <= TO_DATE('2014-07-09', 'YYYY-MM-DD')
;     
-- ===============================================
--(문제해결) 테이블 조인을 통해서 문제해결(안되면 단일 SELECT문으로 단계적으로)
--실습 : '야구를 부탁해'라는 책이 몇 권이 팔렸는지 확인해주세요.
--실습 : '야구를 부탁해'라는 책이 팔린 날짜를 구하세요
--실습 : '야구를 부탁해'라는 책(BOOK)을 구입한(ORDERS) 사람(CUSTOMER)은
----     누구인지 확인
--실습 : '추신수'가 구입한 책값과 구입일자 확인
--실습 : '추신수'가 구입한 책값의 합계금액 구하세요
--실습 : '야구를 부탁해'라는 책(BOOK)을 구입한(ORDERS) 사람(CUSTOMER)과 
----    구입일자를 구하세요.
--실습 : '추신수', '장미란'이 구입한 책과 구입금액, 구입일자를 확인
--      (정렬 : 고객명, 구입일자 순으로)
--------------------------------------------------
--실습 : '야구를 부탁해'라는 책이 몇 권이 팔렸는지 확인해주세요.
SELECT * FROM BOOK WHERE BOOKNAME = '야구를 부탁해'; --BOOKID: 8
SELECT COUNT(*) FROM ORDERS WHERE BOOKID = 8;
---
SELECT '야구를 부탁해 판매건수', COUNT(*)
--SELECT COUNT(*)
  FROM ORDERS O, BOOK B
 WHERE O.BOOKID = B.BOOKID
   AND B.BOOKNAME = '야구를 부탁해'
;
--------------
--실습 : '야구를 부탁해'라는 책이 팔린 날짜를 구하세요
SELECT B.BOOKNAME, O.ORDERDATE
  FROM ORDERS O, BOOK B
 WHERE O.BOOKID = B.BOOKID
   AND B.BOOKNAME = '야구를 부탁해'
;
--------
--실습 : '야구를 부탁해'라는 책(BOOK)을 구입한(ORDERS) 사람(CUSTOMER)은
----     누구인지 확인
SELECT B.BOOKNAME, C.NAME
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID AND O.CUSTID = C.CUSTID
   AND B.BOOKNAME = '야구를 부탁해'
;
------
--실습 : '추신수'가 구입한 책값과 구입일자 확인
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '추신수'
;
------
--실습 : '추신수'가 구입한 책값의 합계금액 구하세요
SELECT '추신수 구입합계 ', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '추신수'
;

--실습 : '야구를 부탁해'라는 책(BOOK)을 구입한(ORDERS) 사람(CUSTOMER)과 
----    구입일자를 구하세요.
SELECT B.BOOKNAME, C.NAME, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --조인조건
   AND O.CUSTID = C.CUSTID --조인조건
   AND B.BOOKNAME = '야구를 부탁해' --검색조건
;

--실습 : '추신수', '장미란'이 구입한 책과 구입금액, 구입일자를 확인
--      (정렬 : 고객명, 구입일자 순으로)
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --조인조건
   AND O.CUSTID = C.CUSTID --조인조건
   AND C.NAME IN ('추신수', '장미란')
 ORDER BY C.NAME, O.ORDERDATE
;  
---
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
--SELECT * 
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --조인조건
   AND O.CUSTID = C.CUSTID --조인조건
   AND (C.NAME = '추신수' OR C.NAME = '장미란')
 ORDER BY C.NAME, O.ORDERDATE
; 
-- ====================================
SELECT '추신수', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '추신수'
;
--
SELECT '장미란', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '장미란'
;
--------
/* ************************
SELECT [* | DISTINCT ]{컬럼명,컬럼명,...}
  FROM 테이블명
[WHERE 조건절
 GROUP BY {컬럼명,...}
 HAVING 조건  --GROUP BY 절에 대한 조건
 ORDER BY {컬럼명,... [ASC | DESC] --ASC : 오름차순(기본/생략가능)
                                  --DESC : 내림차순
]
***************************/
--각 이름별 데이타를 모아서 합계
SELECT C.NAME, SUM(O.SALEPRICE),
       COUNT(*), ROUND(AVG(O.SALEPRICE), 2), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
;
SELECT C.NAME, O.SALEPRICE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 ORDER BY C.NAME, O.SALEPRICE
;

