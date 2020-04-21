SELECT SUBSTR('Hello, World', 1, 5) sub, 
       LENGTH('Hello, World') len,
       INSTR('Hello, World', 'o') ins,
       INSTR('Hello, World', 'o', 6) ins2,
       INSTR('Hello, World', 'o', INSTR('Hello, World', 'o') + 1) ins3,
       LPAD('hello', 15, '*') lp,
       RPAD('hello', 15) rp,
       REPLACE('Hello, World', 'll', 'LL') rep,
       TRIM('     Hello     ') tr,
       TRIM('H' FROM 'Hello') tr2 /*참고만*/
FROM dual;

/*
NUMBER 관련 함수
ROUND(숫자, [반올림 위치 - defualt : 0]) : 반올림
    - ROUND(105.54, 1) : 소수점 첫번째 자리까지 결과를 생성 ==? 소수점 두번째 자리에서 반올림 = 105.5
TRUNC(숫자, [내림 위치 - defualt : 0]) : 내림
MOD(피제수, 제수) : 나머지연산
*/
SELECT  ROUND(105.54, 1) round,
        ROUND(105.55, 1) round2,
        ROUND(105.55, 0) round3,
        ROUND(105.55, -1) round4,
        ROUND
FROM dual;

SELECT  TRUNC(105.54, 1) trunc,
        TRUNC(105.55, 1) trunc2,
        TRUNC(105.55, 0) trunc3,
        TRUNC(105.55, -1) trunc4
FROM dual;

SELECT MOD(10,3)
FROM dual;

SELECT MOD(10,3), sal, MOD(sal, 1000)
FROM emp;

/*
날짜 관련 함수
- SYSDATE : 사용중인 오라클 데이터 베이스 서버의 현재 시간, 날짜를 반환한다.
            함수이지만 인자가 없는 함수
            (인자가 없을 경우 JAVA : 메소드()
                            SQL : 함수명

- date type +- 정수 : 일자 더하기 빼기
 정수 1 = 하루
 1/24 = 1 시간
 1/24/60 = 1 분
 
- 리터럴
 숫자 : 1,2,3,4
 문자 : ''
 날짜 : TO_DATE('날짜 문자열', '포맷')
*/

SELECT SYSDATE, SYSDATE + 5
FROM dual;

--fn 1]
SELECT TO_DATE('20191231', 'YYYYMMDD') lastday,
       TO_DATE('20191231', 'YYYYMMDD')-5 lastday_before5,
       SYSDATE now,
       SYSDATE -3 now_before3
FROM dual;

/*
TO_DATE(문자열, 포맷) : 문자열을 포맷에 맞게 해석하여 날짜 타입으로 형변환
TO_CHAR(날짜, 모멧) : 날짜타입을 포멧에 맞게 문자열로 변환
YYYY : 년도
MM : 월
DD : 일자
D : 주간일자(1~7,1-월요일, 2-월요일, ... , 7-토요일)
IW : 주차(52~53)
HH : 시간(12시간)
HH24 : 25시간 표기
MI : 분
SS : 초
*/

--현재시간(SYSDATE) 시분초 단위까지 표현 ==> TO_CHAR를 이용하여 형변환
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
       TO_CHAR(SYSDATE, 'd') d,
       TO_CHAR(SYSDATE - 3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
       TO_CHAR(SYSDATE - 1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1Hour
FROM dual;

--fn 2]
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') dt_dash_with_time,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy
FROM dual;

/*
- MONTHS_BETWEEN(DATE1, DATE2) : DATE1과 DATE2사이의 개월수를 반환
    4가지 날짜 관련함수중에 사용빈도가 낮음
*/

SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21','YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD')),
       MONTHS_BETWEEN(TO_DATE('2020/04/22','YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD'))
FROM dual;

/*
-ADD_MONTHS(DATE1, 가감할 개월수) : DATE1로 부터 두번째 입력된 개월수 만큼 가감한 DATE
*/

--오늘 날짜로부터 5개월 뒤
SELECT ADD_MONTHS(SYSDATE, 5) dt,
       ADD_MONTHS(SYSDATE, -5) dt2
FROM dual;

/*
- NEXT_DAY(date1, 주간일자) : date1이후 등장하는 첫번째 주간일자의 날짜를 반환
*/
SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

/*
- LAST_DAY(DATE1) DATE1이 속한 월의 마지막 날짜를 반환
SYSDATE : 2020/04/21 --> 2020/04/30
*/
SELECT LAST_DAY(SYSDATE)
FROM dual;

--날짜가 속한 월의 첫번째 날짜 구하기(1일)
--SYSDATE로 부터 년월까지의 문자열 구하기
SELECT SYSDATE,
       ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
       TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD')
FROM dual;








