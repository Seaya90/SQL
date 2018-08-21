/* ***********************************
뷰(VIEW) : 하나 또는 하나 이상의 테이블로 부터
     데이타의 부분집합을 테이블인 것처럼 사용하는 객체
  
--뷰(VIEW) 생성문
CREATE VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2, ... , 컬럼별칭n)]
AS
SELECT 문장

--뷰(VIEW) 삭제문
DROP VIEW 뷰이름;
**************************************/   
SELECT O.*, B.BOOKNAME, C.NAME
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME = '박지성'
;
---------
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';

--뷰(VIEW) 생성문
CREATE VIEW VW_BOOK
AS 
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
-----
SELECT *
  FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%')
 WHERE PUBLISHER = '대한미디어'
; 

---뷰(VIEW) 사용 방식은 테이블 사용방식과 동일
SELECT *
  FROM VW_BOOK
 WHERE PUBLISHER = '대한미디어'
;
SELECT *
  FROM BOOK
 WHERE PUBLISHER = '대한미디어'
;
--------------------------------
--뷰(VIEW) 생성 - 컬럼별칭(alias) 사용
CREATE VIEW VW_BOOK2 
(BNAME, PUB, PRICE)
AS
--SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
SELECT BOOKNAME, PUBLISHER, PRICE
  FROM BOOK WHERE BOOKNAME LIKE '%축구%';

----------------------
--뷰(VIEW)생성 - 조인문으로 만든 데이타
CREATE VIEW VW_ORDERS
AS
SELECT B.BOOKNAME, B.PUBLISHER, C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
 ORDER BY O.ORDERID
;
--뷰삭제
DROP VIEW VW_ORDERS;
-------------------
--뷰 사용 조회
SELECT * FROM VW_ORDERS WHERE NAME = '박지성';
SELECT * FROM VW_ORDERS WHERE NAME IN ('김연아', '추신수');
SELECT * FROM VW_ORDERS WHERE SALEPRICE >= 20000;

-------------------
--(실습) 뷰를 생성, 조회, 삭제
--1. VIEW 명칭 : VW_ORD_ALL
----주문정보, 책정보, 고객정보를 모두 조회할 수 있는 형태의 뷰
CREATE VIEW VW_ORD_ALL 
AS
SELECT O.*, 
       B.BOOKNAME, B.PUBLISHER, B.PRICE,
       C.NAME, C.ADDRESS, C.PHONE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID --조인조건
   AND O.CUSTID = C.CUSTID --조인조건
;

--2. 이상미디어에서 출판해서 판매된 책제목, 판매금액, 판매일 조회
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '이상미디어'
; 
---
--뷰는 실제 동작하는 형태는 FROM절에 뷰의 SELECT문이 동작하는 방식
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM (SELECT O.*, 
               B.BOOKNAME, B.PUBLISHER, B.PRICE,
               C.NAME, C.ADDRESS, C.PHONE
          FROM ORDERS O, BOOK B, CUSTOMER C
         WHERE O.BOOKID = B.BOOKID --조인조건
           AND O.CUSTID = C.CUSTID)
 WHERE PUBLISHER = '이상미디어'
; 

--3. 이상미디어 출판사의 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한사람이름, 책제목, 출판사, 원가, 판매가, 판매일자)
---- 정렬 : 구입한사람이름, 구입일자 최근
SELECT NAME, BOOKNAME, PUBLISHER, PRICE, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '이상미디어'
   AND NAME IN ('추신수', '장미란')
 ORDER BY NAME, ORDERDATE DESC
;

--4. 만들고 사용한 뷰(VW_ORD_ALL) 삭제
--DROP VIEW VW_ORD_ALL;
