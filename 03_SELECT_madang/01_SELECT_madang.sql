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
SELECT * FROM BOOK
ORDER BY BOOKNAME; --책이름 기준 가나다순 정렬
SELECT * FROM BOOK ORDER BY BOOKNAME DESC;
--출판사 기준 오름차순, 금액 큰금액 부터
SELECT * FROM BOOK
ORDER BY PUBLISHER, PRICE DESC;
---------------
--AND, OR, NOT
--AND : 출판사 대한미디어, 금액이 3만원 이상인 책 조회
SELECT *
  FROM BOOK
 WHERE PUBLISHER = '대한미디어' AND PRICE >= 30000
;
--OR : 출판사 대한미디어 또는 이상미디어 에서 출판한 책
SELECT * FROM BOOK
 WHERE PUBLISHER = '대한미디어' OR PUBLISHER = '이상미디어'
;
--NOT : 출판사 굿스포츠를 제외하고 나머지 전체
SELECT * FROM BOOK
 WHERE NOT (PUBLISHER = '굿스포츠') --잘 사용 안함
;
SELECT * FROM BOOK
 WHERE PUBLISHER != '굿스포츠' 
;
SELECT * FROM BOOK
 WHERE PUBLISHER <> '굿스포츠'
;
--굿스포츠, 대한미디어 출판사가 아닌 책
SELECT * FROM BOOK
 WHERE NOT (PUBLISHER = '굿스포츠' OR PUBLISHER = '대한미디어')
;
SELECT * FROM BOOK
 WHERE PUBLISHER <> '굿스포츠' AND PUBLISHER <> '대한미디어'
;
----------------------------
--IN : 안에 있냐? (OR문을 단순화)
--(실습)출판사 : 나무수, 대한미디어, 삼성당 에서 출판한 책 조회
SELECT * FROM BOOK
 WHERE PUBLISHER = '나무수' OR PUBLISHER = '대한미디어'
    OR PUBLISHER = '삼성당'
;
SELECT * FROM BOOK
 WHERE PUBLISHER IN ('나무수', '대한미디어', '삼성당');
--(실습)출판사 : 나무수, 대한미디어, 삼성당을 제외한 출판사의 책 조회
SELECT * FROM BOOK
 WHERE PUBLISHER <> '나무수' AND PUBLISHER <> '대한미디어'
   AND PUBLISHER <> '삼성당'
;
SELECT * FROM BOOK
 WHERE PUBLISHER NOT IN ('나무수', '대한미디어', '삼성당');
-------------------
-- 같다(=),크다(>),작다(<),크거나같다(>=),작거나같다(<=)
-- 같지않다/다르다(<>, !=)
--출판된 책중에 8000원 이상이고 22000원 이하인 책(가격순으로 정렬)
SELECT * FROM BOOK
 WHERE PRICE >= 8000 AND PRICE <= 22000
 ORDER BY PRICE;

--BETEEN 값1 AND 값2 : 값1 부터 값2 까지 형태로 사용
SELECT * FROM BOOK
 WHERE PRICE BETWEEN 8000 AND 22000 --경계값 포함
 ORDER BY PRICE;

--NOT BETWEEN 값1(부터) AND 값2(까지)
SELECT * FROM BOOK
 WHERE PRICE NOT BETWEEN 8000 AND 22000 --경계값 포함 안함
 ORDER BY PRICE;

--책제목이 '야구' ~ '올림픽'
SELECT * FROM BOOK
 WHERE BOOKNAME BETWEEN '야구' AND '올림픽'
 ORDER BY BOOKNAME;

--출판사 나무수~삼성당 책 조회
SELECT * FROM BOOK
 WHERE PUBLISHER BETWEEN '나무수' AND '삼성당'
 ORDER BY PUBLISHER;
----------------------------------------------
-- LIKE : '%', '_' 부호와 함께 사용
-- % : 전체(모든것)를 의미
-- _(언더바) : 문자하나에 대하여 모든 것의 의미
-------
--출판사명에 '미디어'라는 단어가 있는 출판사에서 출판한 책 전체 조회
SELECT * FROM BOOK
 WHERE PUBLISHER IN ('대한미디어', '이상미디어')
;
SELECT * FROM BOOK
 WHERE PUBLISHER LIKE '%미디어'; --출판사명이 '미디어'로 끝나는 것

SELECT * FROM BOOK
 WHERE BOOKNAME LIKE '야구%'; --책제목이 '야구'로 시작하는 것

SELECT * FROM BOOK
 WHERE BOOKNAME LIKE '%단계%'; --책제목에 '단계' 단어가 있는 것
-----
--책 제목에 '구' 문자가 있는 책 목록 조회
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%구%';

--책 제목의 두번째 문자가 '구'인 책 목록 조회
--UPDATE BOOK SET BOOKNAME = '우리 야구의 추억' WHERE BOOKID=7;
SELECT * FROM BOOK WHERE BOOKNAME LIKE '_구%';

--책 제목이 2,3번째 문자가 '구의'인 책 목록 조회
SELECT * FROM BOOK WHERE BOOKNAME LIKE '_구의%';
--------------------------------------------------
--======================================
--그룹 함수 : 하나 이상의 행을 그룹으로 묶어서 연산
--COUNT(*) : 데이타 갯수 조회(전체 컬럼에 대하여)
--COUNT(컬럼명) : 데이타 갯수 조회(지정된 컬럼에 한하여)
--SUM(컬럼) : 합계 값 구하기
--AVG(컬럼) : 평균 값 구하기
--MAX(컬럼) : 최대 값 구하기
--MIN(컬럼) : 최소 값 구하기
---------------
SELECT COUNT(*) FROM BOOK; --BOOK 테이블의 데이타 건수 
SELECT * FROM BOOK;

SELECT * FROM CUSTOMER; --데이타 5건 조회
SELECT COUNT(*) FROM CUSTOMER; --5 조회
SELECT COUNT(NAME) FROM CUSTOMER; --5 조회
SELECT COUNT(PHONE) FROM CUSTOMER; --4건 조회 : NULL 값은 갯수에서 제외됨 
---
--SUM(컬럼) : 컬럼의 합계 값 구할 때
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500
SELECT SUM(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('대한미디어', '이상미디어'); --90000

--AVG(컬럼) : 컬럼의 평균 값 구할 때
SELECT * FROM BOOK;
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT AVG(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('대한미디어', '이상미디어');

--MAX(컬럼) : 컬럼의 값중에 가장 큰 값 조회
--MIN(컬럼) : 컬럼의 값중에 가장 작은 값 조회
SELECT * FROM BOOK ORDER BY PRICE DESC;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK
 WHERE PUBLISHER = '굿스포츠'
;
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
  FROM BOOK;
--------------------------------
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID: 1
SELECT * FROM ORDERS;
--(실습)
--1. 박지성의 총구매액(박지성의 고객번호(CUSTID = 1))
SELECT '박지성', SUM(SALEPRICE) FROM ORDERS
 WHERE CUSTID = 1; --박지성

--2. 박지성이 구매한 도서의 수(COUNT)
SELECT '박지성', COUNT(*) FROM ORDERS
 WHERE CUSTID = 1;

--3. 성이 '김'씨인 고객의 이름과 주소
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '김%';

--4. 성이 '박'씨이고 이름이 '성'로 끝나는 고객의 이름과 주소
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '박%성';
---------------------------------
-- LIKE 알아보기
CREATE TABLE TEST_LIKE (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO TEST_LIKE (ID,NAME) VALUES (1, '홍길동');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (2, '홍길동2');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (3, '홍길동구');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (4, '홍길동대문');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (5, '홍길동2다');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (6, '김홍길동');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (7, '김만홍길동');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (8, '김홍길동만');
INSERT INTO TEST_LIKE (ID,NAME) VALUES (9, '김홍길동만이다');
COMMIT;

SELECT * FROM TEST_LIKE;
SELECT * FROM TEST_LIKE WHERE NAME = '홍길동';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '홍길동';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '홍길동%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '홍길동2%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '%홍길동%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_홍길동_';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_홍길동%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '_홍길동_%';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '__홍길동%';




