CREATE TABLE DEPT (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES ('10', '총무부');
INSERT INTO DEPT VALUES ('20', '급여부');
INSERT INTO DEPT VALUES ('30', '전산부');
COMMIT;

/* ****************************
--테이블 생성시 제약조건 설정
--컬럼 정의하면서 컬럼레벨에서 제약조건 지정
--외래키(FOREIGN KEY) 지정으로 관계 설정 
--형태 : 컬럼명 REFERENCES 대상테이블(대상컬럼)
*******************************/
--컬럼 레벨에서 외래키 설정
CREATE TABLE EMP01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT(ID) --외래키 설정
);
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', 10); --정상입력 처리

--ORA-02291: integrity constraint (MADANG.SYS_C007025) violated - parent key not found
--부모테이블(DEPT)의 ID컬럼에 40이라는 값이 없어서 오류 발생
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍두께', '직무2', 40);

--------------------------------------------
--테이블 레벨 방식으로 제약조건 지정
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY(EMPNO), --PRIMARY KEY 설정
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', 10); --정상입력 처리
--오류발생
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍두께', '직무2', 40);

----------------------------------------
--제약조건명을 명시적으로 선언해서 사용
--형태 : CONSTRAINT 제약조건이름 제약조건
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO),
    CONSTRAINT EMP03_DEPTNO_FK 
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', 10); --정상입력 처리
--오류발생
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍두께', '직무2', 40);

-----------------------------------
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
   AND A.TABLE_NAME LIKE 'EMP%'
 ORDER BY 1
;   

-------------------------------------------
--복합키를 기본키로 설정(PRIMARY KEY) 지정
CREATE TABLE HSCHOOL (
    HAK NUMBER(2),
    BAN NUMBER(2),
    BUN NUMBER(2),
    NAME VARCHAR2(30),
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
INSERT INTO HSCHOOL VALUES (1,1,1, '홍길동');
INSERT INTO HSCHOOL VALUES (1,1,2, '홍길동2');
INSERT INTO HSCHOOL VALUES (1,1,3, '홍길동3');
INSERT INTO HSCHOOL VALUES (2,1,1, '강감찬');

--ORA-00001: unique constraint (MADANG.HSCHOOL_HAK_BAN_BUN_PK) violated
INSERT INTO HSCHOOL VALUES (1,1,1, '강감찬2'); --입력안됨

-------------------------------------------
/* ***** 제약조건 추가, 삭제 **************
--제약조건 추가
ALTER TABLE 테이블명 ADD CONSTRAINT 제약명 제약형태 (컬럼명);

--제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
*****************************************/

--EMP01 테이블의 PRIMARY KEY 삭제(SYS_C007024)
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007024;

--INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무1', 10);

--EMP01 테이블에 PRIMARY KEY 추가
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
--INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무1', 10);

-----------------------
--EMP01 테이블의 외래키(FOREIGN KEY) 삭제 후 추가
--외래키 SYS_C007025 삭제
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007025;

--외래키 추가(EMP01_DEPTNO_FK)
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_DEPTNO_FK
FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

----------------------------------------------
/* *** 제약조건을 활성화 또는 비활성화
-- 제약조건이 설정되어 있는 것을 적용해제 또는 적용
ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약명;
ALTER TABLE 테이블명 ENABLE CONSTRAINT 제약명;
***************************************/
INSERT INTO EMP01 VALUES (3333, '삼국지', '직무2', 40);

--외래키 비활성화(EMP01_DEPTNO_FK)
ALTER TABLE EMP01 DISABLE CONSTRAINT EMP01_DEPTNO_FK;

--외래키 활성화(EMP01_DEPTNO_FK)
ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DEPTNO_FK;

--=============================================



