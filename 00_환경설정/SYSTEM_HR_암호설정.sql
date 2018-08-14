오라클 설치 
- sys/system 암호 : manager

system 유저로 로그인 후 사용자 HR 설정 수정
- HR 암호설정 : hrpw
- 비밀번호 잠김 해제
- 계정잠짐 해제

-------------------------------------------
-- USER SQL
ALTER USER "HR" IDENTIFIED BY "hrpw" 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- QUOTAS
ALTER USER "HR" QUOTA UNLIMITED ON USERS;

-- ROLES
ALTER USER "HR" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES
---------------------------------------------

/* MYSTUDY 유저 생성 및 권한 부여 */
---------------------------------------
-- USER SQL
CREATE USER mystudy IDENTIFIED BY "mystudypw"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER mystudy QUOTA UNLIMITED ON USERS;

-- ROLES
GRANT "CONNECT" TO mystudy ;
GRANT "RESOURCE" TO mystudy ;

-- SYSTEM PRIVILEGES
GRANT CREATE VIEW TO mystudy ;
--------------------------------------