/*
여러줄 주석
*/
--한줄 주석 : 자바의 한줄주석(//)과 동일한 기능
SELECT * FROM STUDENT;

--데이타 추가 : 데이타 입력(INSERT)
INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH) 
VALUES ('2018001', '홍길동', 100, 90, 80);
COMMIT; --COMMIT : 데이타 확정 저장
ROLLBACK;

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2018002', '김유신', 95, 90, 80);
INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2018003', '강감찬', 95, 90, 80);
COMMIT;
-------
SELECT * FROM STUDENT;
------------------------------
--수정 : 데이타 수정(UPDATE)
--강감찬 수학점수 : 80 -> 88 수정
SELECT * FROM STUDENT WHERE NAME = '강감찬';
UPDATE STUDENT
   SET KOR = 90, ENG = 88, MATH = 77
 WHERE NAME = '강감찬';
COMMIT;
--------------------------------
--수정 : 김유신 -> 을지문덕 이름 변경
SELECT * FROM STUDENT;
SELECT * FROM STUDENT WHERE NAME = '김유신';
SELECT * FROM STUDENT WHERE ID = '2018002';
INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2018004', '김유신', 90, 90, 90);

SELECT * FROM STUDENT WHERE ID = '2018002';
UPDATE STUDENT
   SET NAME = '을지문덕'
 WHERE ID = '2018002'; -- =,>,<,>=,<=,!=,<>
--------------------------------- 
--삭제 : 데이타 삭제(DELETE)
SELECT * FROM STUDENT WHERE NAME = '강감찬';
DELETE FROM STUDENT WHERE NAME = '강감찬';
COMMIT;
DELETE FROM STUDENT WHERE NAME = '김유신';
-------------------------------------------
--SELECT 컬럼,.. FROM 테이블 WHERE ...;
--INSERT INTO 테이블 () VALUES ();
--UPDATE 테이블 SET 컬럼 = 값 WHERE ...;
--DELETE FROM 테이블 WHERE ...;




