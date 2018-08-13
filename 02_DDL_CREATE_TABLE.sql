/* *************************
데이타 정의어
- DDL(Data Definition Language) : 데이타를 정의하는 언어
- CREATE(생성), DROP(삭제), ALTER(수정)
- {}반복가능, []생략가능, | 또는(선택)
CREATE TABLE 테이블명 (
{컬럼명 데이타타입
    [NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
}
    [PRIMARY KEY 컬럼명]
    {[FOREIGN KEY 컬럼명 REFERENCES 테이블명(컬럼명)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
--------
컬럼의 기본 데이타 타입
VARCHAR2(n) : 문자열 가변길이
CHAR(n) : 문자열 고정길이
NUMBER(p, s) : 숫자타입 p:전체길이, s:소수점이하 자리수
  예) (5,2) : 정수부 3자리, 소수부 2자리 - 전체 5자리
DATE : 날짜형 년,월,일 시간 값 저장

문자열 처리 : UTF-8 형태로 저장
- 숫자, 알파벳 문자, 특수문자 : 1 byte 처리(키보드 자판 글자들)
- 한글 : 3 byte 처리
***************************/
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, --UNIQUE + NOT NULL
    NAME VARCHAR2(30) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(200)
);
INSERT INTO MEMBER 
       (ID, NAME, PASSWORD)
VALUES ('hong', '홍길동', '1234');

INSERT INTO MEMBER
       (ID, NAME, PASSWORD)
VALUES ('hong2', '홍길동', '1234'); 
---
INSERT INTO MEMBER
       (ID, NAME)
VALUES ('hong3', '홍길동3'); --cannot insert NULL into ("MYSTUDY"."MEMBER"."PASSWORD")      

----
INSERT INTO MEMBER
       (ID, NAME, PASSWORD)
VALUES ('hong4', '홍길동4', '1234');
---------------------------------
SELECT * FROM MEMBER;
--컬럼을 명시적으로 쓰지 않고 INSERT 문 사용시
--테이블에 있는 모든 컬럼에 대하여 순서대로 데이타 입력해야 함
INSERT INTO MEMBER
VALUES ('hong5', '홍길동5', '1234', '010-1111-1111', '서울시');
INSERT INTO MEMBER 
VALUES ('hong6', '홍길동5', '1234', '서울시', '010-1111-1111');

INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS, PHONE)
VALUES ('hong7', '홍길동7', '1234', '서울시', '010-1111-1111');
-----------------------------
--컬럼 특성을 확인하기 위한 테이블
CREATE TABLE TEST (
    NUM NUMBER(5,2), --전체자리수 5, 정수부 3, 소수부 2
    STR1 CHAR(10), --고정길이
    STR2 VARCHAR2(10), --가변길이
    DATE1 DATE
);
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT * FROM TEST;
INSERT INTO TEST VALUES (100.456, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.454, 'ABC', 'ABC', SYSDATE);
SELECT '-'|| STR1 ||'-', '-'||STR2||'-' FROM TEST;
INSERT INTO TEST VALUES (100.454, 'DEF', 'DEF  ', SYSDATE);
-----
SELECT * FROM TEST WHERE STR1 = STR2; --조회된 데이타 없음
SELECT * FROM TEST WHERE STR1 = 'ABC'; --오라클에서는 조회됨
--'ABC' 문자열비교 'ABC       '
SELECT * FROM TEST WHERE STR1 = 'ABC       '; --모든DB 적용
-------                  
SELECT * FROM TEST WHERE NUM = 100.45; --NUMBER = NUMBER
SELECT * FROM TEST WHERE NUM = '100.45'; --오라클 조회됨 NUMBER = VARCHAR
SELECT * FROM TEST WHERE NUM = '100.45A'; --ORA-01722: invalid number
---
INSERT INTO TEST (STR1, STR2) VALUES ('1234567890', '1234567890');
SELECT * FROM TEST;
SELECT * FROM TEST WHERE STR1 = STR2;
SELECT '-'|| STR1 ||'-', '-'||STR2||'-' FROM TEST;
--------------------------------
--UTF-8 타입으로 데이타 저장
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', 'ABCDEFGHIJ');
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '대한민국'); --4 x 3byte = 12
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '홍길동'); --3 x 3byte = 9

-- ========================================================
-- NULL (널) : 빈문자열('')도 아니고, 특정 값이 아닌 데이타가 없는 상태
-- NULL은 비교처리가 안됨 : =,<>,>,<,>=,<= 비교처리가 의미가 없음
-- NULL 과의 연산 결과는 항상 NULL(연산의 의미도 없음)
-- NULL 값에 대한 조회는 IS NULL, IS NOT NULL 문장으로 조회
------------------
SELECT * FROM TEST WHERE NUM = NULL; --조회데이타 없음
SELECT * FROM TEST WHERE NUM IS NULL;
SELECT * FROM TEST WHERE NUM <> NULL; --조회 안됨
SELECT * FROM TEST WHERE NUM IS NOT NULL;

--NULL 과의 연산 결과
SELECT NUM + 10 FROM TEST;
SELECT NUM + NULL FROM TEST; --NULL과의 연산결과는 NULL
--정렬시 NULL
SELECT * FROM TEST ORDER BY STR1; --ASC 키워드 생략
SELECT * FROM TEST ORDER BY STR1 DESC;
--정렬시 오라클에서는 NULL 값을 가장 큰 값으로 처리(맨 마지막에 출력)
--NULL값의 순서 변경처리 : NULLS FIRST, NULLS LAST
SELECT * FROM TEST ORDER BY NUM;
SELECT * FROM TEST ORDER BY NUM DESC;
SELECT * FROM TEST ORDER BY NUM NULLS FIRST; --NULL값을 맨처음 표시
SELECT * FROM TEST ORDER BY NUM DESC NULLS LAST;

--
SELECT NUM FROM TEST;
--내장함수 NVL(컬럼, 설정값) - 컬럼이 NULL이면 설정값으로 변환
SELECT NUM, NUM + 10, NVL(NUM, 0) + 100 FROM TEST;
-----------
SELECT * FROM TEST;
INSERT INTO TEST (NUM, STR1, STR2) VALUES (200, '', NULL);
SELECT * FROM TEST WHERE STR1 = '';
SELECT STR1, STR1||'-테스트',
       NVL(STR1, '내용없음') || '-테스트' 
  FROM TEST;
-- =================================
/* (실습) 테이블명 : TEST2
    NO : 숫자타입 5자리, PRIMARY KEY 선언
    ID : 문자타입 10자리(영문10자리), 값이 반드시 존재
    NAME : 한글 10자리 저장가능토록 설정, 값이 반드시 존재
    EMAIL : 영문, 숫자, 특수문자 포함 30자리 
    ADDRESS : 한글 100자리
    IDNUM : 숫자타입 정수부 7자리, 소수부 3자리(1234567.789)
    REGDATE : 날짜타입
*****************************/



