--상관서브쿼리(메인쿼리와 서브쿼리가 조인되어 동작)
--------------------
--출판사별로 출판사별 평균 도서가격보다 비싼 도서 목록을 구하시오
SELECT *
  FROM BOOK B
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK
                 WHERE PUBLISHER = '굿스포츠')
   AND B.PUBLISHER = '굿스포츠'
;
----
--메인 SELECT문의 데이타 하나가 처리될 때마다 메인테이블의 값과
--비교해서 서브쿼리 문장이 실행되는 형태로 처리
SELECT *
  FROM BOOK B
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK
                 WHERE PUBLISHER = B.PUBLISHER)
;
----- JOIN문
--출판사별 평균 도서 가격
SELECT PUBLISHER, AVG(PRICE)
  FROM BOOK
 GROUP BY PUBLISHER
;
----
SELECT *
  FROM BOOK B
     , (SELECT PUBLISHER, AVG(PRICE) PUB_AVG_PRICE
          FROM BOOK
         GROUP BY PUBLISHER
       ) AVG
 WHERE B.PUBLISHER = AVG.PUBLISHER 
   AND B.PRICE >= AVG.PUB_AVG_PRICE
;
------------------
-- SELECT 절에 사용된 상관서브쿼리
SELECT O.*
     , (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUST_NAME
     , (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOK_NAME
  FROM ORDERS O
;

---------------------------------------
--EXISTS : 존재여부 확인시 사용(있으면 true)
--NOT EXISTS : 존재하지 않을 때 ture
SELECT BOOKNAME, '데이타 있음'
  FROM BOOK
 WHERE EXISTS (SELECT 1
                 FROM BOOK
                WHERE BOOKNAME LIKE '%축구%' 
              )
;
--주문내역이 있는 고객의 이름과 전화번호를 찾으시오
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID
                    FROM ORDERS)
;
-- ===> EXISTS 적용
SELECT *
  FROM CUSTOMER C
 WHERE EXISTS (SELECT 1
                 FROM ORDERS
                WHERE CUSTID = C.CUSTID)
; 
---- NOT EXISTS
SELECT *
  FROM CUSTOMER C
 WHERE NOT EXISTS (SELECT 1
                 FROM ORDERS
                WHERE CUSTID = C.CUSTID)
; 
--=====================================
--UNION, UNION ALL : 합집합 처리
--단, 조회하는 컬럼의 이름, 순서, 숫자, 타입이 일치하도록 작성
--UNION : 중복데이타를 제외하고 합해줌
--UNION ALL : 중복데이타를 포함해서 합해줌
---------------
-- UNION 사용 예제
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3)
 ORDER BY NAME
;
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5)
 ORDER BY NAME
;
----- 장미란 데이타가 1개만 출력
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
UNION
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(장미란), 추신수, 박세리
;
---- UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(장미란), 추신수, 박세리
;
----------------------------
--MINUS : 차집합(빼기연산)
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
MINUS
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(장미란), 추신수, 박세리
;
---------------------
--INTERSECT : 교집합(중복데이타 조회) - 조인문의 동등비교 결과 동일
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
INTERSECT
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --(장미란), 추신수, 박세리
;
--- JOIN 문
SELECT A.*
  FROM (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
       ) A,
       (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (3, 4, 5) --(장미란), 추신수, 박세리
       ) B
 WHERE A.CUSTID = B.CUSTID
   AND A.NAME = B.NAME
;   





