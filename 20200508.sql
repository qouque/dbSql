제약조건
1. PRIMARY KEY
2. UNIQUE
3. FOREIGN KEY
4. CHECK
    .NOT NULL
5] NOT NULL
    CHECK 제약 조건이지만 많이 사용하기 때문에 별도의 KEYWORD를 제공
 

NOT NULL 제약조건
 : 컬럼에 값이 NULL이 들어오는 것을 방지하는 제약 조건

DROP TABLE dept_test;


CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) NOT NULL,
	loc VARCHAR2(13)
);


dname 컬럼에 설정된 NOT NULL 제약조건에 의해 아래 INSERT 구문은 실패한다.
INSERT INTO dept_test VALUES (99, NULL, 'daejeon');

문자열의 경우 ''를 NULL로 인식한다.
아래의 INSERT 구문도 에러
INSERT INTO dept_test VALUES (99, '', 'daejeon');

UNIQUE 제약
해당컬럼에 동일한 값이 중복되지 않도록 제한
테이블의 모든 행중 해당 컬럼에 값은 중복되지 않고 유틸해야함
EX : 직원, 사번컬럼, 학생 테이블의 학번 컬럼

DROP TABLE dept_test;


CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) UNIQUE,
	loc VARCHAR2(13)
);

dept_test테입ㄹ의 우믇의 컬럼은   UNIQUE 제약이 있기 때문에 동일한 값이 들어갈 수 없다.
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(98, 'ddit', '대전');

복합 컬럼에 대한 UNIQUE 제약 설정
DROP TABLE dept_test;


CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14),
	loc VARCHAR2(13),
    
    CONSTRAINT u_dept_test UNIQUE (dname,loc)
);

dname 컬럼과 loc 컬럼이 동시에 동일한 값이어야만 중복으로 인식
밑에 두개의 쿼리는 데이터 중복이 아니므로 정상 실행
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(98, 'ddit', '대전');

아래쿼리는 UNIQUE제약 조건에 의해 입력되지 않는다
INSERT INTO dept_test VALUES(97, 'ddit', '대전');

SELECT *
FROM dept_test;



FOREIGN KEY 제약조건
입력하고자 하는 데이터가 탑조하는 테이블에 존재 할 때만 입력 허용
ex : emp 테이블에데이터를 입력할 때 deptno 컬럼의 값이 dept 테이블에 존재하는 deptno 값 
     이어야 입력가능

데이터 입력시(emp) 참조하는 테이블(dept)에 데이터 존재 유무를 빠르게 알기 위해서
참조하는 테이블(dept)의 컬럼(deptno)에 인덱스가 반드시 생성 되어 있어야만
FOREIGN KEY 제약조건을 추가 할 수 있다.

UNIQUE 제약조건을 생성할 경우 해당 컬럼의 값 중복 체크를 빠르게 하기 위해서
오라클에서는 해당 컬럼에 인덱스가 없을경우 자동으로 생성한다.

PRIMARY KEY 제약조건 : UNIQUE 제역 + NOT NULL 제약
PRIMARY KEY제약조건만 생성해도 해당 컬럼으로 인덱스를 생성 해준다.


FOREIGN KEY 제약조건은 참조하는 테이블이 있기 때문에 두개의 테이블간 설정한다.


DROP TABLE dept_test;

CREATE TABLE dept_test (
	deptno NUMBER(2, 0) PRIMARY KEY,
	dname VARCHAR2(14),
	loc VARCHAR2(13)
    
);

INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
COMMIT;

;
CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0) REFERENCE dept_test (deptno)
    
);

현재 부서 테이블에는
99번부서만 존재
foreign key 제약조건에 의해 emp 테이블의 deptno 컬럼에는 99번 이외의 부서번호는 입력될 수 없다.

99번 부서는 존재하므로 정상적으로 입력 가능
INSERT INTO emp_test VALUES(9999, 'brown', 99);

98번 부서는 존재하지 않으므로 정상적으로 입력 불가능
INSERT INTO emp_test VALUES(9999, 'brown', 98);

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)
    
    
);

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0),
    
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno)
);


외래키와 데이터 삭제
INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;

emp_test.deptno ===> dept_test_deptno 참조중
(9999, 'brown', 99) ===> (99, 'ddit', 'daejeon');

detp_test 테이블의 99번 부서의 데이터를 지우면 어떻게 될까?
(9999, 'brown', 99) ===>

부모 레코드(dept_test.deptno)를 참조하고 있는 자식 레코드(emp_test.deptno)가
존재하기 때문에 자식 레코드 입장에서는 데이터 무결성이 깨지게 되어
정상적으로 삭제 할 수 없다
DELETE dept_test
WHERE deptno = 99;

참조키와 관련된 데이터를 삭제시 부여할 수 있는 옵션
부모 데이터를 삭제시...
FOREIGN KEY 옵션에 따라 자식 데이터를 처리할 수 있는 옵션
1. default ==> 참조하고 있는 부모가 삭제 될 수 없다.
2. ON DELETE CASCADE ==> 부모가 삭제되면 참조하고 있는 자식 데이터도 같이 삭제
3. ON DELETE SET NULL ==> 부모가 삭제되면 참조하고 있는 자식 데이터를 NULL로 설정

주관적인 의견 : default
1. 개발자가 테이블의 순서를 명확하게 알고 있어야지만 로직 제어할 수 있음
    ==> wldnrjsk, dlqfurgkf epdlxjdml tnstjfmf dkfrh dlTdjdigka.
2. 테이블 명세서가 정확하지 않으면 신규 개발자는 해당 내용을 모를 수가 있음
    (java코드 + 테이블 내역 확인 필요)
    java코드에는 dept테이블만 삭제하는 코드가 있는데
    신가하게도 emp테이블의 데이터가 삭제되거나 null로 설정되는 경우를 볼 수 있음
    
CHECK 제약 조건
컬럼의 값을 제한하는 제약 조건

emp 테이블에서 급여정보(sal)를 관리 할때 sal 컬럼의 값은 0보다 작은 값이 들어가는 것은 
로직적으로 이상함.
sal 컬럼의 값이 음수가 들어가지 않도록 체크 조건을 이용하여 방지 할 수 있다.
;
DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) CHECK (sal > 0),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)  
);

INSERT INTO emp_test VALUES (9999, 'brown', 1000, 99);

sal컬럼에 설정된 check제약 조건 ( sal > 0 )에 의해 정상적으로 실행되지 않는다.
INSERT INTO emp_test VALUES (9998, 'sally', -1000, 99);



DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno),
    
    CONSTRAINT c_emp_test_sal CHECK (sal > 0)

);

INSERT INTO emp_test VALUES (9999, 'brown', 1000, 99);

sal컬럼에 설정된 check제약 조건 ( sal > 0 )에 의해 정상적으로 실행되지 않는다.
INSERT INTO emp_test VALUES (9998, 'sally', -1000, 99);

CTAS : Create Table AS
SELECT 결과를 이요하여 테이블을 생성하는 명령
NOT NULL 제약조건 제외한 다른 제약조건은 복사되지 않는다
용도
    1. 개발자 레벨의 백업
    2. 개발자 레벨의 테스트

문법
CREATE TABLE 테이블명 [(컬럼명1, ...)] AS
    SELECT 쿼리;
    
dept_test 테이블을 복사 ==> dept_test_copy
CREATE TABLE dept_test_copy AS
SELECT *
FROM dept_test;

데이터 없이 테이블을 복사 하고 싶을 때
CREATE TABLE dept_test_copy2 AS
SELECT *
FROM dept_test
WHERE 1 != 1;

SELECT *
FROM dept_test_copy;

JAVA JDBC (Java DataBase Connection)
String sql = "실행할 sql";

직원 검색 기능을 개발
요구조건 : 직원 이름으로 검색, 전체 검색, 급여검색;
직원 이름검색
SELECT *
FROM emp
WHERE ename LIKE '%' || 검색키워드 || '%';

전체 검색
SELECT *
FROM emp;

급여 검색
SELECT *
FROM emp
WHERE sal > 검색값;

String sql = "SELECT *";
       sql += " FROM emp";
       sql += "WHERE 1=1";
       
if(사용자가 급여검색을 요청 했다면){
    sql += " AND sal > " + 사용자가 입력한 검색값;
}

if(사용자가 직원 이름 검색을 요청 했다면){
    sql += "AND ename LIKE '%' || " + 사용자가 입력한 이름 검색 값 + "'%'";

String sql = "SELECT *";
       sql += " FROM emp";
       sql += "WHERE 1=1";
       sql += "AND sal > " + 사용자가 입력한 검색값; 
       sql += "AND ename LIKE '%' || " + 사용자가 입력한 이름 검색 값 + "'%'";

TABLE 수정
지금까지 위에서 TABLE 생성만 했음.
이미 생성된 테이블을 수정 할 수도 있음
    1. 새로운 컬럼을 추가
    ****** 새로운 컬럼은 테이블의 마지막 컬럼으로 추가가 된다
    ****** 기존 생성되어 있는 컬럼 중간에는 새로운 컬럼을 추가할 수가 없다
            ==> 기존 테이블을 삭제하고 컬럼순서를 조정한 새로운 테이블 생성 DDL로
                새롭게 만들어야 함
                운영중이라면 이미 데이터가 쌓여있을 가능성이 굉장히 높음
                ==> 테이블을 생성할 때 신중하게 컬럼 순서를 고려
    2. 기존 컬럼 삭제, 컬럼 이름 변경, 컬럼 사이즈 변경 (타입도 제한적으로 변경 가능)
       참조키가 걸려있는 테이블의 컬럼 이름을 변경하더라도 참조하는 테이블에는 영향이 가지 않음.
       (알아서 이름을 변경 해준다)
       emp_test.deptno ==> dept_test.deptno 참조
       dept_test.deptno 이름변경하여 dept_test.dno로 수정하더라도 fk는 변경된 이름으로 잘 유지가된다.
       
    3. 제약 조건추가

기존 테이블에 새로운 컬럼 추가;
ALTER TABLE 테이블명 ADD (컬럼명 컬럼타입);

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)
);

DESC emp_test;

emp_test 테이블이 hp컬럼 (VARCHAR(20))을 신규로 추가

ALTER TABLE emp_test ADD (hp VARCHAR(20));

DESC emp_test;

SELECT *
FROM emp_test;

컬럼 사이즈, 컬람 타입 변경
ALTER TABLE 테이블명 MODIFY (컬럼명 컬럼타입);

위에서 추가한 hp 컬럼의 컬럼 사이즈를 20에서 30으로 변경
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

DESC emp_test;

컬럼 타입 변경
위에서 추가한 HP컬럼의 타입을 VARCHAR2(30)에서 DATE로 변경
ALTER TABLE emp_test MODIFY (hp DATE);

DESC emp_test;

데이터가 존재하는 컬럼에 대해서는 타입 벼경이 불가능 하다
INSERT INTO emp_test VALUES (9999, 'brown', 99);
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

컬럼 이름 변경
ALTER TABLE emp_test RENAME COLUMN 기존 컬럼명 TO 신규 컬럼명;

위에서 추가한 emp_test 테이블의 hp 컬럼을 hp_n으로 이름변경
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

DESC emp_test;

컬럼 삭제

ALTER TABLE 테이블명 DROP (삭제할 컬럼명);
ALTER TABLE 테이블명 DROP COLUMN (삭제할 컬럼명);

위에서 추가한 EMP_TEST테이블의 hp_n 컬럼을 삭제;
ALTER TABLE emp_test DROP (hp_n);

SQL 종류
DML : SELECT, INSERT, UPDATE, DELETE ==> 트랜잭셔 제어 가능 (취소 가능.)
DDL : CREATE....., ALTER..., ==> 트랜잭션 제어 불가능 (취소가 안된다.) / 자동 커밋

ROLLBACK;

SELECT *
FROM emp_test;

기존 ename 은 brown ==> sally로 변경
UPDATE emp_test SET ename = 'sally'
WHERE empno = 9999;

롤백 또는 커밋을 안함.
ALTER TABLE emp_test ADD (hp NUMBER);

DESC emp_test;

ROLLBACK;

SELECT*
FROM emp_test;

DDL은 자동 커밋이기 때문에 DML 문장에도 영향을 받는다
DDL을 실행할 경우 주위 깊게 이전에 했던 작업을 살펴볼 필요가 있따
SQLD 시험에도 잘나오는 문제

