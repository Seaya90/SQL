/* **************************** 
-- INSERT 문
INSERT INTO 테이블명
       (컬럼명1, 컬럼명2, ..., 컬럼명n)
VALUES (값1, 값2, ... , 값n);  
*********************************/
SELECT * FROM BOOK;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (30, '자바란 무엇인가', 'ITBOOK', 30000);  
COMMIT;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (31, '자바란 무엇인가2', 'ITBOOK', 30000); 
---
-- 컬럼명을 나열하지 않는 경우 
-- 테이블 생성시 컬럼의 순서대로 데이타 입력되고,
-- 반드시 모든 컬럼의 값을 입력해야 한다.
INSERT INTO BOOK
VALUES (32, '자바란 무엇인가3', 'ITBOOK', 30000);
INSERT INTO BOOK
VALUES (33, 'ITBOOK', '자바란 무엇인가3', 30000);
--컬럼의 값을 누락하는 경우 
--SQL 오류: ORA-00947: not enough values
INSERT INTO BOOK
VALUES (34, '자바란 무엇인가4', 'ITBOOK');

--------------
--컬럼명을 작성하면, 컬럼명 작성항목에만 데이타 매칭 입력
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER)
VALUES (35, '자바란 무엇인가5', 'ITBOOK');
--
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PRICE, PUBLISHER)
VALUES (36, '자바란 무엇인가6', 30000, 'ITBOOK'); 
------------------
--일괄입력 : 테이블의 데이타를 이용해서 데이타 입력
--IMPORTED_BOOK -> BOOK : 일괄입력
INSERT INTO BOOK
SELECT BOOKID,BOOKNAME, PUBLISHER, PRICE
  FROM IMPORTED_BOOK
;

/* *********************************
--UPDATE문
UPDATE 테이블명
   SET 컬럼명1 = 값1, 컬럼명2 = 값2, ..., 컬럼명n = 값n
 [WHERE 대상조건 ]
*********************************/
SELECT * FROM CUSTOMER;
--박세리의 주소 : '대한민국 대전' -> '대한민국 부산'
UPDATE CUSTOMER
   SET ADDRESS = '대한민국 부산'
 WHERE NAME = '박세리'
;   
SELECT * FROM CUSTOMER WHERE NAME = '박세리';
COMMIT;
---------
--박세리 주소, 전화번호 : '대한민국 대전', '010-1111-2222'
UPDATE CUSTOMER
   SET ADDRESS = '대한민국 대전',
       PHONE = '010-1111-2222'
 WHERE NAME = '박세리'
; 
------------------------
--박세리 주소 수정: 김연아의 주소와 동일하게 변경
SELECT ADDRESS FROM CUSTOMER WHERE NAME = '김연아';
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER 
                   WHERE NAME = '김연아')
 WHERE NAME = '박세리'
;
SELECT * FROM CUSTOMER WHERE NAME = '박세리';
-----------
--박세리 주소, 전화번호 수정 : 추신수 정보와 동일하게
