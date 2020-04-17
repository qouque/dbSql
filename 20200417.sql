/*
-SERLECT 에서 연산 : 
    날짜 연산(+, -) : 날짜 + 정수, -정수 ㅣ 날짜에서 +- 한 과거 혹은 미래일자의 데이트 타입 변환
    정수 연산(....) : 수업시간에 다루진 않음...
    문자열연산
        리터럴 : 표기방법
                    숫자 리터럴 : 숫자로 표현
                    문자 리터럴 : JAVA : "문자열"/ SQL : 'SQL'
                                SELECT SELECT * FROM || table_name
                                SELECT 'SECLECT * FROM' || table_name
                        문자열 결합 연산 : +가 아니라 ||(java 에서는 +)
                    날짜?? : TO_DATE('날짜 문자열', '날짜 문자열에 대한 포맷')
                            TO_DATE('20200417','YYYYMMDD')
                            
- WHERE : 기술한 조건에 만족하는 행만 조회 되도록 제한
*/
SELECT *
FROM users
WHERE userid = 'brown';

SELECT *
FROM users
WHERE 1 = 1;

SELECT *
FROM users
WHERE 1 != 1;

-- sal값이 100보다 크거나 같고, 2000보다 작거나 같은 직원만 죄회 ==> BETWEEN, AND
-- 비교대상 컬럼 / 값 BETWEEN 시작값 AND 종료값
-- 시작값과 종료값의 위치를 바꾸면 정상 동작하지 않음


SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

-- exclusive or (베타적 or)
-- a or b
SELECT *
FROM emp
WHERE sal >= 1000
  AND sal <= 2000;

--WHERE 1
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND TO_DATE('1983/01/01', 'YYYY/MM/DD');

/*
-- IN 연산자
- 컬럼 : 특정값 IN (값1, 값2, ...)
- 컬럼이나 특정값이 괄호안에 값중에 하나라도 일치하면 TRUE
*/

SELECT *
FROM emp
WHERE deptno IN (10, 30);
--> deptno가 10이거나 30번인 직원
-- deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;

--users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회 하시오(IN 연산자 사용 --WHERE3--
SELECT userid AS "아이디", usernm AS "이름", alias AS "별명"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

/*
- 문자열매칭 연산 : LIKE 연산 / JAVA : .startsWith(prefix), .endsWith(suffix)
- 마스킹 문자령 :  % - 모든 문자열(공백 포함)
                 _ - 어떤 문자열이든지 딱 하나의 문자
- 문자열의 일부가 맞으면 TRUE!!

-컬럼 : 특정값 LIKE 패턴 문자열;

-'cony' : cony인 문자열
-'co%'  : 문자열이 co로 시작하고 뒤에는 어떤 문자열이든 올 수있는 문자열
          'cony', 'con', 'co'
'%co%'  : co를 포함하는 문자열
          'cony', 'sallt cony'
'co__'(언더바 2개) : co로 시작하고 뒤에 두개의 문자가 오는 문자열
'_on_' : 가운데 두글자가 on이고 앞뒤로 어떤 문자열이든지 하나의 문자가 올수 있는 문자열
*/

--직원 이름(ename)이 대문자 S로 시작하는 직원만 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--member 테이블에서 회원의 성이 [신]씨인 사람의mem_id, mem_name을 조회하는 쿼리를 작성하시오
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

--이름에 [이]가 들어가는 사람을 조회하는 쿼리
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

/*
NUL 비교
SQL 비교연산자 : =
*/

--MGR 컬럼 값이 없는 모든 직원을 조회
SELECT *
FROM emp
WHERE mgr = NULL;

-- SQL 에서 NULL 값을 비교할 경우 일반적인 비교연산자(=)를 사용 못하도
-- IS 연산자를 사용

SELECT *
FROM emp
WHERE mgr IS NULL;

/*
- 값이 있는 상황에서 등가 비교 =, !=, <>
NULL : IS NULL, IS NOT NULL
*/

-- emp 테이블에서 mrg 컬럼 값이 NULL이 아닌 직원을 조회
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

-- emp 테이블에서 상여(comm)가 있는 회원의 정보를 다음과 같이 조회되도록 쿼리를 작성하시오.
-- WHERE6]
SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE mgr = 7698
  AND sal > 1000;

SELECT *
FROM emp
WHERE mgr = 7698
   OR sal > 1000;

--IN연산자를 비교연산자로 변경
SELECT *
FROM emp
WHERE mgr IN (7698, 7839);
--> WHERE mgr = 7698 OR mgr = 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
--> WHERE (mgr != 7698 AND mgr != 7839)

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
   OR mgr IS NULL;

--WHERE 7]
--emp 테이블에서 job이 SALESMAN이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('19810601', 'YYYYMMDD')
  AND sal > 1300;
-- 키워드 관해서는 대소문자 구분은 안하지만, 데이터 값은 대소문자 구별을 한다 주의!!

-- WHERE 8]
-- emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
-- (IN, NOT IN 연산자 사용금지)
SELECT *
FROM emp
WHERE deptno != 10 
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
--(NOT IN 연산자 사용)
SELECT *
FROM emp
WHERE deptno NOT IN 10 
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--WHERE 10]
--emp 테이블에서 부서번호가 10번이 아니고 1981년 6월 1일 이후에 입사 직원의 정보를 조회
--(단 부서번호는 10, 20, 30번만 있다고 가정하고 IN연산자를 사용)
SELECT *
FROM emp
WHERE deptno IN (20,30)
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--WHERE 11]
--enp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 조회하시오
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--WHERE 12]
--emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%'; --empno테이블은 number, 형변환이 발생
-- '78%'은 LIKE랑 같이 사용

--WHERE 13]
--
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno = 78
   OR empno >= 780 AND empno < 790
   OR empno >= 7800 AND empno < 7900;

/*
- 연산자 우선순위
1. 산술연산자(+,-,...)
2. 문자열결합(||)
3. 비교연산(=, <=, >=, ...)
4. IS,[NOT]NULL, LIKE, [NOT] IN
5. [NOT] BETWEEN
6. NOT
7. AND
8. OR
*/

--WHERE 14]
--emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 사원의 정보를 조회
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR empno LIKE '78%'
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

/*
- 집합 : [a, b, c] == [a, c, b]
- table에는 조회, 저장시 순서가 없어(보장하지않음)
==> 수학시간의 집합과 유사한 개념

SLQ에서는 데이터를 정렬하려면 별도의 구문이 필요.
--ORDER BY 컬럼명 [정렬형태], 컬럼명2 [정렬형태], ...

정렬의 형태 : 오름차순(DEFALLT) - ASC, 내림차순 - DESC
*/

--직원 이름으로 오름 차순정렬
SELECT *
FROM emp
ORDER BY ename ASC;

--직원 이름으로 내림 차순정렬
SELECT *
FROM emp
ORDER BY ename DESC;
--job을 기준으로 오름차순정렬하고 job이 같을경우 입사일자로 내림차순 정렬
--모든 데이터 조회
SELECT *
FROM emp
ORDER BY job ASC, hiredate DESC;





