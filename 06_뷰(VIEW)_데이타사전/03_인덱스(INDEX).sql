/* *********************************
<인덱스 - INDEX>
테이블에 있는 데이타(로우, 레코드)를 빠르게 찾기 위해 만들어진 데이타 구조
- 자동인덱스 : PRIMARY KEY 선언시 또는 UNIQUE 제약조건 설정시 생성되는 인덱스
- 수동인덱스 : CREATE INDEX 명령문을 사용해서 만드는 인덱스

<인덱스 생성시 고려사항>
-인덱스는 WHERE절에 자주 사용되는 컬럼에 적용
-조인조건에 자주 사용되는 컬럼에 적용
-단일 테이블에 인덱스가 너무 많아도 속도 저하 문제 발생(테이블당 4~5정도)
-컬럼의 데이타가 변경(입력,수정,삭제)되는 경우가 많으면 사용자제
-컬럼의 데이타 분포도가 낮을 때 효율 증가

<인덱스 생성 문법>
CREATE INDEX 인덱스명 ON 테이블명 (컬럼명1[, 컬럼명2, ..., 컬럼명n]);
CREATE [UNIQUE] INDEX ON 테이블명 (컬럼명1 [ASC|DESC], 컬럼명2, .., 컬럼명n);

<인덱스 삭제 문법>
DROP INDEX 인덱스명;

<인덱스 재구성 문법>
ALTER INDEX 인덱스명 REBUILD;
ALTER [UNIQUE] INDEX 인덱스명 [ON 테이블명 (컬럼명, ...)] REBUILD;
************************************/

--인덱스 생성 : BOOK 테이블의 출판사(PUBLISHER) 컬럼에 IX_BOOK 인덱스 만들기
CREATE INDEX IX_BOOK ON BOOK (PUBLISHER);
SELECT * FROM BOOK ORDER BY PUBLISHER;
SELECT * FROM BOOK WHERE PUBLISHER = '굿스포츠';
DROP INDEX IX_BOOK;

--인덱스생성(2개 컬럼기준)
--BOOK 테이블의 PUBLISHER, PRICE 컬럼을 대상으로 IX_BOOK2 인덱스 생성
CREATE INDEX IX_BOOK2 ON BOOK (PUBLISHER, PRICE);
SELECT PUBLISHER, PRICE FROM BOOK ORDER BY PUBLISHER, PRICE;

--당연히 인덱스 사용됨
SELECT * FROM BOOK WHERE PUBLISHER = '굿스포츠' AND PRICE = 8000;
--WHERE절의 비교조건이 순서가 달라도 결과값이 동일한 경우 인덱스 적용
SELECT * FROM BOOK WHERE PRICE = 8000 AND PUBLISHER = '굿스포츠';

--PUBLISHER, PRICE 를 이용해 생성된 인덱스 사용 가능
SELECT * FROM BOOK WHERE PUBLISHER = '대한미디어'; --인덱스 적용됨

--인덱스 적용됨
SELECT * FROM BOOK WHERE PUBLISHER BETWEEN '굿스포츠' AND '대한미디어';

--LIKE 조건 사용시 : 인덱스 적용됨
SELECT * FROM BOOK WHERE PUBLISHER LIKE '대한%';

--LIKE 조건 사용시 : 인덱스 적용안됨
SELECT * FROM BOOK WHERE PUBLISHER LIKE '%대한%';

--원본데이타를 가공처리한 경우 인덱스 적용 안됨
SELECT * FROM BOOK WHERE SUBSTR(PUBLISHER,1,2) = '대한';

--PUBLISHER, PRICE 를 이용해 생성된 인덱스의 2번째 항목부터는 
--단독 인덱스로 적용안됨(별도 생성 사용)
SELECT * FROM BOOK WHERE PRICE = 8000;

----------------------------------
/* *** 인덱스 실습 ****************************
마당서점 데이터베이스에서 다음 SQL 문을 수행하고 
데이터베이스가 인덱스를 사용하는 과정을 확인하시오.
(1) 다음 SQL 문을 수행해본다.
	SELECT name FROM Customer WHERE name LIKE '박세리';
(2) 실행 계획을 살펴본다. 실행 계획은 [F10]키를 누른 후 
    [계획 설명]탭을 선택하면 표시된다.
(3) Customer 테이블에 name으로 인덱스(ix_customber_name)를 생성하시오. 
    생성 후 (1)번의 질의를 다시 수행하고 실행 계획을 살펴보시오.
(4) 같은 질의에 대한 두 가지 실행 계획을 비교해보시오.
(5) (3)번에서 생성한 인덱스를 삭제하시오.
******************************************/
SELECT name FROM Customer WHERE name LIKE '박세리'; --FULL SCAN

--(3) 인덱스 생성(ix_customber_name)
CREATE INDEX ix_customber_name ON CUSTOMER (NAME);

SELECT name FROM Customer WHERE name LIKE '박세리'; --RANGE SCAN

--(5) 인덱스 삭제
DROP INDEX ix_customber_name;

