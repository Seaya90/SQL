SELECT * FROM BOOK;

--ROWNUM : 오라클에서 제공하는 <가상의 ROW 번호> 컬럼
--데이타가 조회순으로 값이 정해지는 방식
SELECT ROWNUM, B.* FROM BOOK B WHERE ROWNUM <= 5;
SELECT ROWNUM, B.* FROM BOOK B
 ORDER BY PRICE; --정렬시 ROWNUM이 1~N 오름차순 정렬이 깨짐

--ROWNUM을 항상 1~N 형태로 유지하려면 
--ORDER BY 적용 후 ROWNUM 조회
SELECT ROWNUM, B.*
  FROM (SELECT * FROM BOOK
        ORDER BY PRICE
       ) B
 WHERE ROWNUM <= 5
; 

SELECT *
  FROM (SELECT ROWNUM RNO, B.*
          FROM (SELECT * FROM BOOK
                ORDER BY PRICE
               ) B
       )
 WHERE RNO BETWEEN 6 AND 10    
; 
--=======================================
/********************
DECODE, CASE : SQL문 내에서 IF문 구현
DECODE : 오라클과 지원되는 DB에서만 사용가능
CASE : ANSI 표준으로 모든 DB에서 사용가능(단, 지원안하면 사용못함)
*********************/
/*** DECODE 함수
DECODE 함수는 동등비교만 가능
DECODE(대상, 비교값, 대상=비교값 경우 처리문, 대상<>비교값인 경우처리문);
DECODE(대상, 비교값, DECODE(), DECODE());
DECODE(대상, 비교값1, 처리문1
          , 비교값2, 처리문2 
          ... 
          , 비교값n, 처리문n
          , 처리문n+1);
*****************************/
SELECT * FROM CUSTOMER ORDER BY NAME;

--이름이 김연아면 '야~ 김연아다!!!' 아니면 '누구세요?' 출력
SELECT NAME, 
       DECODE(NAME, '김연아', '야~ 김연아다!!!', '누구세요?')
  FROM CUSTOMER
 ORDER BY NAME;

--이름이 박지성이면 '축구선수', 아니면 '운동선수'
SELECT NAME, 
       DECODE(NAME, '박지성', '축구선수', '운동선수')
  FROM CUSTOMER
 ORDER BY NAME;
---------------
--이름이 김연아면 '피겨스케이팅', 박세리면 '골프', 박지성이면 '축구선수'
--나머지 '운동선수'
--IF(){} ELSE IF(){} ELSE IF(){}.. ELSE {}
--DECODE(NAME,'김연아','피겨스케이팅','박세리','골프','박지성','축구선수','운동선수')
SELECT NAME,
       DECODE(NAME, '김연아', '피겨스케이팅',
                    '박세리', '골프',
                    '박지성', '축구선수',
                    '운동선수')
  FROM CUSTOMER
 ORDER BY NAME;
---------------
--DECODE문의 TRUE, FALSE 처리시 DECODE문 사용 가능
SELECT NAME,
       DECODE(NAME, '김연아', '김연아다',
                    DECODE(NAME, '박세리', '박세리다',
                                 DECODE(NAME, '박지성', '박지성이다','잘모르겠다')  
                          ) 
             )
  FROM CUSTOMER
 ORDER BY NAME;

--===============================================
/***** CASE 문 ************
형태1 : SWITCH CASE처럼(DECODE문 처럼)
CASE 컬럼(기준값)
     WHEN 비교값1 THEN 일치하면 처리할 구문
     WHEN 비교값2 THEN 일치하면 처리할 구문
     ...
     WHEN 비교값n THEN 일치하면 처리할 구문
     ELSE 위에 일치하는 경우가 없으면 실행할 구문
END
--------
형태2 : IF THEN ELSE 처럼 사용(부등비교 처리 가능)
--CASE문 내의 처리문장에는 CASE중복 사용 가능
--비교구문 : =, <>, !=, >, <, >=, <=, AND, OR, NOT 사용가능
CASE WHEN 비교구문
     THEN 비교구문 결과 TRUE인 경우 처리구문
     ELSE 비교구문 결과 FALSE인 경우 처리구문
END   

CASE WHEN 비교구문(예: KOR > 90)
     THEN (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
     ELSE (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
END   

CASE WHEN 비교구문 THEN 처리구문
     WHEN 비교구문 THEN 처리구문
     ....
     ELSE 위의 비교구문에 해당되지 않는 경우 처리구문
END 
***************************/
SELECT * FROM CUSTOMER ORDER BY NAME;
--이름이 박지성이면 '축구선수' 아니면 '운동선수' 출력
SELECT NAME,
       CASE NAME WHEN '박지성' THEN '축구선수' ELSE '운동선수' END           
  FROM CUSTOMER
 ORDER BY NAME;
--
SELECT NAME,
       CASE NAME WHEN '박지성' 
                 THEN '축구선수' 
                 ELSE '운동선수' 
       END           
  FROM CUSTOMER
 ORDER BY NAME;
-------------------
--이름이 김연아->피겨스케이팅, 박세리->골프, 박지성->축구, 나머지 운동선수
SELECT NAME,
       CASE NAME
            WHEN '김연아' THEN '피겨스케이팅'
            WHEN '박세리' THEN '골프'
            WHEN '박지성' THEN '축구'
            ELSE '운동선수'
       END 
  FROM CUSTOMER
 ORDER BY NAME;
-- DECODE문
SELECT NAME,
       DECODE(NAME, '김연아', '피겨스케이팅',
                    '박세리', '골프',
                    '박지성', '축구선수',
                    '운동선수')
  FROM CUSTOMER
 ORDER BY NAME;
--------------------------------
--BOOK 테이블의 가격을 이용한 비교 처리
SELECT * FROM BOOK ORDER BY PRICE;
----------
--가격(PRICE)이 10000 미만이면 '싸다', 10000 ~ 20000: '적당하다'
--20000보다 크면 '비싸다', 30000 보다 크면 '너무비싸다'
SELECT B.*,
       CASE WHEN PRICE < 10000 
            THEN '싸다'
            ELSE CASE WHEN PRICE <= 20000
                      THEN '적당하다'
                      ELSE CASE WHEN PRICE <= 30000
                                THEN '비싸다'
                                ELSE '너무비싸다'
                           END
                 END
       END AS "가격평가"
  FROM BOOK B
 ORDER BY PRICE;
--------------
--추가요청사항 발생 : 7000보다 적으면 '껌값이네' 추가
SELECT B.*,
       CASE WHEN PRICE < 7000
            THEN '껌값이네'
            ELSE
               CASE WHEN PRICE < 10000 
                    THEN '싸다'
                    ELSE CASE WHEN PRICE <= 20000
                              THEN '적당하다'
                              ELSE CASE WHEN PRICE <= 30000
                                        THEN '비싸다'
                                        ELSE '너무비싸다'
                                   END
                         END
               END
       END 
  FROM BOOK B
 ORDER BY PRICE;
----
SELECT B.*,
       CASE WHEN PRICE < 10000 
            THEN CASE WHEN PRICE < 7000
                      THEN '껌값이네'
                      ELSE '싸다'
                 END   
            ELSE CASE WHEN PRICE <= 20000
                      THEN '적당하다'
                      ELSE CASE WHEN PRICE <= 30000
                                THEN '비싸다'
                                ELSE '너무비싸다'
                           END
                 END
       END AS "가격평가"
  FROM BOOK B
 ORDER BY PRICE;
-------------------------- 
SELECT B.*,
       CASE WHEN PRICE < 7000 THEN '껌값이네'
            WHEN PRICE < 10000 THEN '싸다'
            WHEN PRICE <= 20000 THEN '적당하다'
            WHEN PRICE <= 30000 THEN '비싸다'
            ELSE '너무비싸다'
       END
  FROM BOOK B
 ORDER BY PRICE;

