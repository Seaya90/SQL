/***** 트랜잭션(TRANSACTION) *******
트랜잭션(TRANSACTION) : DBMS에서 데이타를 다루는 논리적인 작업의 단위

<트랜잭션의 종료>
COMMIT : 작업 내용을 DB에 반영하고 트랜잭션 종료

<트랜잭션 일부 또는 전체 무효화>
ROLLBACK; --최종 COMMIT 시점부터 모두 취소
ROLLBACK TO 세이브포인트이름; --세이브포인트위치까지 취소

<세이브포인트 설정>
SAVEPOINT 세이브포인트이름;
**********************************/
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
INSERT INTO DEPT1 VALUES ('40', '인사부');
COMMIT; --묵시적 SAVEPOINT 설정됨
---
SELECT * FROM DEPT;
SELECT * FROM DEPT1;

--DEPT1 테이블에서 ID: 40 데이타 삭제
DELETE FROM DEPT1 WHERE ID = '40';
SELECT * FROM DEPT1;

--세이브포인트 설정 : S1
SAVEPOINT S1;

-->>삭제 ID: 20
DELETE FROM DEPT1 WHERE ID = '20';
SELECT * FROM DEPT1;

--세이브포인트 설정 : S2
SAVEPOINT S2;

-->>삭제 ID: 10
DELETE FROM DEPT1 WHERE ID = '10';
SELECT * FROM DEPT1;

-------------------
--트랜잭션 되돌리기(ROLLBACK)
--ROLLBACK; --최종 COMMIT 시점까지 되돌리기
--ROLLBACK TO 세이브포인트; --세이브포인트 지점까지 ROLLBACK;
SELECT * FROM DEPT1;

--S2까지 ROLLBACK
ROLLBACK TO S2;
SELECT * FROM DEPT1; --10	총무부 복구됨(되돌리기 ROLLBACK)

--S1까지 ROLLBACK
ROLLBACK TO S1;
SELECT * FROM DEPT1; --20	급여부 삭제작업 ROLLBACK 처리됨

--최종 COMMIT 시점까지 ROLLBACK
ROLLBACK;
SELECT * FROM DEPT1;

