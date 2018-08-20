/* *********************************
--테이블 생성 : CREATE TABLE 테이블명 ();
CREATE TABLE 테이블명 (
    컬럼명1 데이타타입(크기) [제약조건],
    컬럼명2 데이타타입(크기) [제약조건],
    ...
    컬럼명n 데이타타입(크기) [제약조건]
);

제약조건
-- PRIMARY KEY : 기본키 - NOT NULL + UNIQUE 제한조건 충족
-- NOT NULL : 값이 반드시 있어야 함(NULL값 허용안함)
-- UNIQUE : 컬럼내에서 유일한 값(같은 값은 하나만 존재)
-- CHECK : 입력되는 값 체크(만족하면 입력, 불만족 입력안됨)
-- DEFAULT : 값이 입력되지 않을 때 초기값 적용
***********************************/
CREATE TABLE DDL_TEST (
    ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL UNIQUE,
    PHONE VARCHAR2(20) DEFAULT '전화없음',
    KOR NUMBER(3) DEFAULT 0 CHECK(KOR BETWEEN 0 AND 100),
    REGDATE DATE DEFAULT SYSDATE
);
----
INSERT INTO DDL_TEST (ID) VALUES (1); --NAME 컬럼 NOT NULL 제약조건 위반
INSERT INTO DDL_TEST (NAME) VALUES ('김유신'); --ID 컬럼 NOT NULL 제약조건 위반
INSERT INTO DDL_TEST (ID, NAME) VALUES (1, '홍길동');

--오류: check constraint (MADANG.SYS_C007020) violated
INSERT INTO DDL_TEST (ID, NAME, KOR) VALUES(2, '김유신', 200); --KOR: 0~100

INSERT INTO DDL_TEST (ID, NAME, KOR) VALUES(2, '김유신', 100);
------------------------------------
--======================================
-- 테이블, 컬럼에 주석 만들기
-- COMMENT ON TABLE 테이블명 IS '테이블주석';
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '컬럼주석';

--테이블에 대한 주석 작성
--COMMENT ON TABLE "MADANG"."BOOK"  IS '책정보';
COMMENT ON TABLE BOOK  IS '책정보주석';

--컬럼에 대한 주석문(설명) 작성
COMMENT ON COLUMN BOOK.BOOKID IS '책ID';
COMMENT ON COLUMN BOOK.BOOKNAME IS '책제목';
COMMENT ON COLUMN BOOK.PUBLISHER IS '출판사명';
COMMENT ON COLUMN BOOK.PRICE IS '판매원가';

--------------------------------------
--(실습) DDL_TEST 테이블에 주석 달기
--DDL_TEST 테이블 주석
COMMENT ON TABLE DDL_TEST IS '테이블제약조건';

--DDL_TEST 테이블의 컬럼 주석
COMMENT ON COLUMN DDL_TEST.ID IS '아이디';
COMMENT ON COLUMN DDL_TEST.NAME IS '성명';
COMMENT ON COLUMN DDL_TEST.PHONE IS '전화번호';
COMMENT ON COLUMN DDL_TEST.KOR IS '국어점수';
COMMENT ON COLUMN DDL_TEST.REGDATE IS '등록일';

--테이블, 컬럼의 주석 확인(조회) - 뷰정보 조회
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME = 'DDL_TEST';
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'DDL_TEST';

--============================================
/*************************************
<데이타 사전>
데이터베이스 관리 시스템(Database Management System, 이하 DBMS)을 
효율적으로 사용하기 위해 데이터베이스에 저장된 정보를 요약한 것이다
--사용자에게 뷰(VIEW)형태로 제공
************************************/ 
--사용 가능한 데이타 사전 보기
SELECT * FROM DICT ORDER BY TABLE_NAME;

--설치되어 있는 데이타베이스의 버전 정보 확인
SELECT * FROM V$VERSION;

DESC BOOK;
SELECT * FROM TAB;

--테이블 정보 확인
SELECT * FROM USER_TABLES; --테이블정보
--컬럼정보 확인
SELECT * FROM USER_TAB_COLS ORDER BY TABLE_NAME, COLUMN_ID;
SELECT * FROM USER_TAB_COLUMNS ORDER BY TABLE_NAME, COLUMN_ID;

-------------
--제약조건의 확인
--USER_CONS_COLUMNS : 컬럼에 할당된 제약조건 조회
--USER_CONSTRAINTS : 유저(DB)가 소유한 모든 제약 조건 조회
SELECT * FROM USER_CONS_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;

--제약조건 조회
SELECT A.TABLE_NAME,
       A.COLUMN_NAME,
       A.CONSTRAINT_NAME,
       B.CONSTRAINT_TYPE,
       DECODE(B.CONSTRAINT_TYPE,
              'P', 'PRIMARY KEY',
              'U', 'UNIQUE',
              'C', 'CHECK OR NOT NULL',
              'R', 'FOREIGN KEY') CONSTRINT_TYPE_DESC
  FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
 WHERE A.TABLE_NAME = B.TABLE_NAME
   AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
   AND A.TABLE_NAME = 'DDL_TEST'
 ORDER BY 1
;   
   









