
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

ROWID : ���̺� ���� ����� �����ּ�
        (java = �ν��Ͻ� ����
            e = ������  )
;
SELECT ROWID, emp.*
FROM emp;

����ڿ� ���� ROWID ���;
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE ROWID = 'AAAE5xAAFAAAAEVAAF';

SELECT *
FROM TABLE(dbms_xplan.display);


2 - 1 - 0

Plan hash value: 2949544139
 
--------------------------------------------------------------------------------------
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    38 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    38 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7369)


INDEX �ǽ�
emp���̺� ���� ������ pk_emp PRIMARY ���������� ����

ALTER TABLE emp DROP CONSTRAINT pk_emp;

�ε��� ���� empno���� �̿��Ͽ� ������ ��ȸ
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;


SELECT *
FROM TABLE(dbms_xplan.display);

2. emp ���̺� empno�÷����� PRIMARY KEY ���������� ����
    (empno �÷����� ������ unique �ε����� ����)
;
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

3. 2�� sql�� ���� (SELECT �÷��� ����)

2��
SELECT *
FROM emp
WHERE empno = 7782;

3��;
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

4. empno�÷��� non-unique �ε����� �����Ǿ� �ִ� ���
ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_emp_01 ON emp (empno); --non-unique �ε���


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

5. emp ���̺��� job ���� ��ġ�ϴ� �����͸� ã�� ���� ��
���� �ε���
idx_emp_01 : empno
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

idx_emp_01�� ��� ������ empno�÷� �������� �Ǿ� �ֱ� ������ job �÷��� �����ϴ�
SQL������ ȿ�������� ����� ���� ���� ������ TABLE ��ü �����ϴ� ������ �����ȹ�� ������

==> idx_emp_02 (job ������ ���� �����ȹ ��)
CREATE INDEX idx_emp_02 ON emp (job);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);

6. emp���̺��� job = 'MANAGEER' �̸鼭 ename �� c�� �����ϴ� ����� ��ȸ
�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

7. emp���̺��� job = 'MANAGEER' �̸鼭 ename �� c�� �����ϴ� ����� ��ȸ
�� ���ο� �ε��� �߰� : idx_emp_03 : job,ename
CREATE INDEX idc_emp_03 ON emp (job,ename);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idc_emp_03 : job, empno

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

7-1. emp���̺��� job = 'MANAGEER' �̸鼭 ename �� c�� ������ ����� ��ȸ

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE '%C';



SELECT *
FROM TABLE(dbms_xplan.display);

RULE BASED OPTINIZER : ��Ģ��� ����ȭ�� (9i)
COST BASED OPTINIZER : ����� ����ȭ�� (10g)


9. ���� �÷� �ε����� �÷� ������ �߿伺
�ε��� ���� �÷� : (job, ename) vs (ename, job)
*** �����ؾ� �ϴ� sql�� ���� �ε��� �÷� ������ �����ؾ� �Ѵ�.

���� sql : job-manager, ename�� C�� �����ϴ� ��� ������ ��ȸ( ��ü �÷�)
���� �ε��� ���� : idx_emp_03;
DROP INDEX idx_emp_03;

�ε��� �ű� ����
idx_emp_04 : ename, job
CREATE INDEX idx_emp_04 ON emp (ename, job);


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
  AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

�ε��� ��Ȳ
idx_emp_01 : empno
idx_emp_02 : job
idc_emp_04 : empno, job

RULE BASED OPTINIZER : ��Ģ��� ����ȭ�� (9i) ==> ���� ī�޶�
COST BASED OPTINIZER : ����� ����ȭ�� (10g) ==> �ڵ� ī�޶�


���ο����� �ε���
idx_emp_01 ����(pk_emp �ε����� �ߺ�)
DROP INDEX idx_emp_01;

emp ���̺� empno�÷��� PRIMARY KEY�� �������� ����
pk_emp : empno;
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

�ε��� ��Ȳ
pk_emp : empno
idx_emp_02 : job
idc_emp_04 : empno, job
;

EXPLAIN PLAN FOR
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

NESTED LOOP JOIN
HASH JOIN
SORT MERGE JOIN

