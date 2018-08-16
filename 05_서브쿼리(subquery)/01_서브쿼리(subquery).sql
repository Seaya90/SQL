--서브쿼리(부속질의, subquery)
--SQL문(SELECT, INSERT, UPDATE, DELETE) 내에 있는 쿼리문(SELECT)
-----------------------------------
--'박지성'이 구입한 내역을 검색
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID: 1
SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');
--
SELECT C.NAME, O.* 
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '박지성'
;
----
SELECT * FROM ORDERS
 WHERE CUSTID IN (SELECT CUSTID 
                   FROM CUSTOMER 
                  WHERE NAME IN ('박지성', '김연아'));
------------------
--정가가 가장 비싼 도서의 이름을 구하시오
--서브쿼리 WHERE절에 사용
SELECT MAX(PRICE) FROM BOOK; --35000
SELECT * FROM BOOK
 WHERE PRICE = 35000;
--
SELECT * FROM BOOK
 WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);

--------------------
--서브쿼리를 FROM절에 사용
SELECT B.*
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE --조인조건
;
--
SELECT *
  FROM (SELECT * FROM CUSTOMER WHERE NAME IN ('박지성','김연아')) C,
       ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
--
SELECT *
  FROM CUSTOMER C,
       ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME IN ('박지성', '김연아')
;
----------------------------------
--SELECT 절에 서브쿼리 사용예
SELECT O.ORDERID, O.CUSTID, O.BOOKID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, --고객명
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME, --책제목
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;
--------------------------
--박지성이 구매한 책 목록(제목)
--맨 안쪽SQL -> 중간 SQL -> 맨 바깥쪽 SQL문 실행
SELECT BOOKNAME
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID = (SELECT CUSTID
                                     FROM CUSTOMER
                                    WHERE NAME = '박지성')
                  )
;                  
------------------------
--실습(서브쿼리 이용)
--1. 한 번이라도 구매한 내역이 사람
--2. 20000원 이상되는 책을 구입한 고객 명단 조회(서브쿼리,조인문)
--3. '대한미디어' 출판사의 도서를 구매한 고객이름 조회(서브쿼리,조인문)
--4. 전체 책가격 평균보다 비싼 책의 목록 조회(서브쿼리, 조인문)
-----------











