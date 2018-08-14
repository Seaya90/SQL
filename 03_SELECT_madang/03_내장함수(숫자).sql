/**********************************
<숫자 관련 내장함수>
숫자함수 : SQL에서는 사칙연산(+, -, *, /)과 나머지 연산(MOD) 사용
ABS(숫자) : 절대값
FLOOR(숫자) : 소수점 아래 버림
CEIL(숫자) : 올림 
ROUND(숫자) : 반올림 - 소수점 이하 반올림
ROUND(숫자, 자리수) : 자리수 이하 반올림 예) ROUND(95.789, 2) -> 95.79
TRUNC(숫자) : 정수만 남기고, 소수부 버림
TRUNC(숫자, 자리수) : 정수 이하 자리수까지 유지 
MOD(숫자, 나누는수) : 나머지
SIGN(숫자) : 부호값 반환(양수: 1, 영: 0, 음수: -1)
POWER(숫자, n) : 숫자의 n제곱 근 값 계산(POWER(2, 3) -> 8) 
***********************************/
SELECT 10+3, 10-3, 10*3, 10/3, MOD(10,3) FROM DUAL;

--ABS(숫자) : 절대값
SELECT ABS(-30.45), ABS(30.45) FROM DUAL;

--FLOOR(숫자) : 소수점 아래 버림
SELECT FLOOR(30.999), FLOOR(30.11) FROM DUAL;

--CEIL(숫자) : 올림
SELECT CEIL(30.999), CEIL(30.11), CEIL(30.0001) FROM DUAL;

--ROUND(숫자) : 반올림 - 소수점 이하 반올림
--ROUND(숫자, 자리수) : 자리수 이하 반올림 예) ROUND(95.789, 2) -> 95.79
SELECT ROUND(30.54), ROUND(30.49) FROM DUAL;
SELECT ROUND(30.55, 1), ROUND(30.45, 1), ROUND(30.44, 1) FROM DUAL;

--TRUNC(숫자) : 정수만 남기고, 소수부 버림
--TRUNC(숫자, 자리수) : 정수 이하 자리수까지 유지 
SELECT TRUNC(30.54), TRUNC(30.49) FROM DUAL;
SELECT TRUNC(30.59, 1), TRUNC(30.45, 1), ROUND(30.44, 1) FROM DUAL;

--SIGN(숫자) : 부호값 반환(양수: 1, 영: 0, 음수: -1)
SELECT SIGN(0), SIGN(65), SIGN(-65) FROM DUAL;

--POWER(숫자, n) : 숫자의 n제곱 근 값 계산(POWER(2, 3) -> 8) 
SELECT POWER(2,3), POWER(2,4), POWER(2,16) FROM DUAL;
SELECT POWER(8,3), POWER(8,4), POWER(8,16) FROM DUAL;


/*



MOD(숫자, 나누는수) : 나머지
SIGN(숫자) : 부호값 반환(양수: 1, 영: 0, 음수: -1)
POWER(숫자, n) : 숫자의 n제곱 근 값 계산(POWER(2, 3) -> 8) 
*/




