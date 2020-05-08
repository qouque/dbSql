��������
1. PRIMARY KEY
2. UNIQUE
3. FOREIGN KEY
4. CHECK
    .NOT NULL
5] NOT NULL
    CHECK ���� ���������� ���� ����ϱ� ������ ������ KEYWORD�� ����
 

NOT NULL ��������
 : �÷��� ���� NULL�� ������ ���� �����ϴ� ���� ����

DROP TABLE dept_test;


CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) NOT NULL,
	loc VARCHAR2(13)
);


dname �÷��� ������ NOT NULL �������ǿ� ���� �Ʒ� INSERT ������ �����Ѵ�.
INSERT INTO dept_test VALUES (99, NULL, 'daejeon');

���ڿ��� ��� ''�� NULL�� �ν��Ѵ�.
�Ʒ��� INSERT ������ ����
INSERT INTO dept_test VALUES (99, '', 'daejeon');

UNIQUE ����
�ش��÷��� ������ ���� �ߺ����� �ʵ��� ����
���̺��� ��� ���� �ش� �÷��� ���� �ߺ����� �ʰ� ��ƿ�ؾ���
EX : ����, ����÷�, �л� ���̺��� �й� �÷�

DROP TABLE dept_test;


CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14) UNIQUE,
	loc VARCHAR2(13)
);

dept_test���Ԥ��� ����� �÷���   UNIQUE ������ �ֱ� ������ ������ ���� �� �� ����.
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(98, 'ddit', '����');

���� �÷��� ���� UNIQUE ���� ����
DROP TABLE dept_test;


CREATE TABLE dept_test (
	deptno NUMBER(2, 0),
	dname VARCHAR2(14),
	loc VARCHAR2(13),
    
    CONSTRAINT u_dept_test UNIQUE (dname,loc)
);

dname �÷��� loc �÷��� ���ÿ� ������ ���̾�߸� �ߺ����� �ν�
�ؿ� �ΰ��� ������ ������ �ߺ��� �ƴϹǷ� ���� ����
INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(98, 'ddit', '����');

�Ʒ������� UNIQUE���� ���ǿ� ���� �Էµ��� �ʴ´�
INSERT INTO dept_test VALUES(97, 'ddit', '����');

SELECT *
FROM dept_test;



FOREIGN KEY ��������
�Է��ϰ��� �ϴ� �����Ͱ� ž���ϴ� ���̺� ���� �� ���� �Է� ���
ex : emp ���̺������͸� �Է��� �� deptno �÷��� ���� dept ���̺� �����ϴ� deptno �� 
     �̾�� �Է°���

������ �Է½�(emp) �����ϴ� ���̺�(dept)�� ������ ���� ������ ������ �˱� ���ؼ�
�����ϴ� ���̺�(dept)�� �÷�(deptno)�� �ε����� �ݵ�� ���� �Ǿ� �־�߸�
FOREIGN KEY ���������� �߰� �� �� �ִ�.

UNIQUE ���������� ������ ��� �ش� �÷��� �� �ߺ� üũ�� ������ �ϱ� ���ؼ�
����Ŭ������ �ش� �÷��� �ε����� ������� �ڵ����� �����Ѵ�.

PRIMARY KEY �������� : UNIQUE ���� + NOT NULL ����
PRIMARY KEY�������Ǹ� �����ص� �ش� �÷����� �ε����� ���� ���ش�.


FOREIGN KEY ���������� �����ϴ� ���̺��� �ֱ� ������ �ΰ��� ���̺� �����Ѵ�.


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

���� �μ� ���̺���
99���μ��� ����
foreign key �������ǿ� ���� emp ���̺��� deptno �÷����� 99�� �̿��� �μ���ȣ�� �Էµ� �� ����.

99�� �μ��� �����ϹǷ� ���������� �Է� ����
INSERT INTO emp_test VALUES(9999, 'brown', 99);

98�� �μ��� �������� �����Ƿ� ���������� �Է� �Ұ���
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


�ܷ�Ű�� ������ ����
INSERT INTO emp_test VALUES(9999, 'brown', 99);
COMMIT;

emp_test.deptno ===> dept_test_deptno ������
(9999, 'brown', 99) ===> (99, 'ddit', 'daejeon');

detp_test ���̺��� 99�� �μ��� �����͸� ����� ��� �ɱ�?
(9999, 'brown', 99) ===>

�θ� ���ڵ�(dept_test.deptno)�� �����ϰ� �ִ� �ڽ� ���ڵ�(emp_test.deptno)��
�����ϱ� ������ �ڽ� ���ڵ� ���忡���� ������ ���Ἲ�� ������ �Ǿ�
���������� ���� �� �� ����
DELETE dept_test
WHERE deptno = 99;

����Ű�� ���õ� �����͸� ������ �ο��� �� �ִ� �ɼ�
�θ� �����͸� ������...
FOREIGN KEY �ɼǿ� ���� �ڽ� �����͸� ó���� �� �ִ� �ɼ�
1. default ==> �����ϰ� �ִ� �θ� ���� �� �� ����.
2. ON DELETE CASCADE ==> �θ� �����Ǹ� �����ϰ� �ִ� �ڽ� �����͵� ���� ����
3. ON DELETE SET NULL ==> �θ� �����Ǹ� �����ϰ� �ִ� �ڽ� �����͸� NULL�� ����

�ְ����� �ǰ� : default
1. �����ڰ� ���̺��� ������ ��Ȯ�ϰ� �˰� �־������ ���� ������ �� ����
    ==> wldnrjsk, dlqfurgkf epdlxjdml tnstjfmf dkfrh dlTdjdigka.
2. ���̺� ������ ��Ȯ���� ������ �ű� �����ڴ� �ش� ������ �� ���� ����
    (java�ڵ� + ���̺� ���� Ȯ�� �ʿ�)
    java�ڵ忡�� dept���̺� �����ϴ� �ڵ尡 �ִµ�
    �Ű��ϰԵ� emp���̺��� �����Ͱ� �����ǰų� null�� �����Ǵ� ��츦 �� �� ����
    
CHECK ���� ����
�÷��� ���� �����ϴ� ���� ����

emp ���̺��� �޿�����(sal)�� ���� �Ҷ� sal �÷��� ���� 0���� ���� ���� ���� ���� 
���������� �̻���.
sal �÷��� ���� ������ ���� �ʵ��� üũ ������ �̿��Ͽ� ���� �� �� �ִ�.
;
DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    sal NUMBER(7,2) CHECK (sal > 0),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)  
);

INSERT INTO emp_test VALUES (9999, 'brown', 1000, 99);

sal�÷��� ������ check���� ���� ( sal > 0 )�� ���� ���������� ������� �ʴ´�.
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

sal�÷��� ������ check���� ���� ( sal > 0 )�� ���� ���������� ������� �ʴ´�.
INSERT INTO emp_test VALUES (9998, 'sally', -1000, 99);

CTAS : Create Table AS
SELECT ����� �̿��Ͽ� ���̺��� �����ϴ� ���
NOT NULL �������� ������ �ٸ� ���������� ������� �ʴ´�
�뵵
    1. ������ ������ ���
    2. ������ ������ �׽�Ʈ

����
CREATE TABLE ���̺�� [(�÷���1, ...)] AS
    SELECT ����;
    
dept_test ���̺��� ���� ==> dept_test_copy
CREATE TABLE dept_test_copy AS
SELECT *
FROM dept_test;

������ ���� ���̺��� ���� �ϰ� ���� ��
CREATE TABLE dept_test_copy2 AS
SELECT *
FROM dept_test
WHERE 1 != 1;

SELECT *
FROM dept_test_copy;

JAVA JDBC (Java DataBase Connection)
String sql = "������ sql";

���� �˻� ����� ����
�䱸���� : ���� �̸����� �˻�, ��ü �˻�, �޿��˻�;
���� �̸��˻�
SELECT *
FROM emp
WHERE ename LIKE '%' || �˻�Ű���� || '%';

��ü �˻�
SELECT *
FROM emp;

�޿� �˻�
SELECT *
FROM emp
WHERE sal > �˻���;

String sql = "SELECT *";
       sql += " FROM emp";
       sql += "WHERE 1=1";
       
if(����ڰ� �޿��˻��� ��û �ߴٸ�){
    sql += " AND sal > " + ����ڰ� �Է��� �˻���;
}

if(����ڰ� ���� �̸� �˻��� ��û �ߴٸ�){
    sql += "AND ename LIKE '%' || " + ����ڰ� �Է��� �̸� �˻� �� + "'%'";

String sql = "SELECT *";
       sql += " FROM emp";
       sql += "WHERE 1=1";
       sql += "AND sal > " + ����ڰ� �Է��� �˻���; 
       sql += "AND ename LIKE '%' || " + ����ڰ� �Է��� �̸� �˻� �� + "'%'";

TABLE ����
���ݱ��� ������ TABLE ������ ����.
�̹� ������ ���̺��� ���� �� ���� ����
    1. ���ο� �÷��� �߰�
    ****** ���ο� �÷��� ���̺��� ������ �÷����� �߰��� �ȴ�
    ****** ���� �����Ǿ� �ִ� �÷� �߰����� ���ο� �÷��� �߰��� ���� ����
            ==> ���� ���̺��� �����ϰ� �÷������� ������ ���ο� ���̺� ���� DDL��
                ���Ӱ� ������ ��
                ����̶�� �̹� �����Ͱ� �׿����� ���ɼ��� ������ ����
                ==> ���̺��� ������ �� �����ϰ� �÷� ������ ���
    2. ���� �÷� ����, �÷� �̸� ����, �÷� ������ ���� (Ÿ�Ե� ���������� ���� ����)
       ����Ű�� �ɷ��ִ� ���̺��� �÷� �̸��� �����ϴ��� �����ϴ� ���̺��� ������ ���� ����.
       (�˾Ƽ� �̸��� ���� ���ش�)
       emp_test.deptno ==> dept_test.deptno ����
       dept_test.deptno �̸������Ͽ� dept_test.dno�� �����ϴ��� fk�� ����� �̸����� �� �������ȴ�.
       
    3. ���� �����߰�

���� ���̺� ���ο� �÷� �߰�;
ALTER TABLE ���̺�� ADD (�÷��� �÷�Ÿ��);

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4, 0) PRIMARY KEY,
    ename VARCHAR2(10),
    deptno NUMBER(2, 0) REFERENCES dept_test (deptno)
);

DESC emp_test;

emp_test ���̺��� hp�÷� (VARCHAR(20))�� �űԷ� �߰�

ALTER TABLE emp_test ADD (hp VARCHAR(20));

DESC emp_test;

SELECT *
FROM emp_test;

�÷� ������, �ö� Ÿ�� ����
ALTER TABLE ���̺�� MODIFY (�÷��� �÷�Ÿ��);

������ �߰��� hp �÷��� �÷� ����� 20���� 30���� ����
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

DESC emp_test;

�÷� Ÿ�� ����
������ �߰��� HP�÷��� Ÿ���� VARCHAR2(30)���� DATE�� ����
ALTER TABLE emp_test MODIFY (hp DATE);

DESC emp_test;

�����Ͱ� �����ϴ� �÷��� ���ؼ��� Ÿ�� ������ �Ұ��� �ϴ�
INSERT INTO emp_test VALUES (9999, 'brown', 99);
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

�÷� �̸� ����
ALTER TABLE emp_test RENAME COLUMN ���� �÷��� TO �ű� �÷���;

������ �߰��� emp_test ���̺��� hp �÷��� hp_n���� �̸�����
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

DESC emp_test;

�÷� ����

ALTER TABLE ���̺�� DROP (������ �÷���);
ALTER TABLE ���̺�� DROP COLUMN (������ �÷���);

������ �߰��� EMP_TEST���̺��� hp_n �÷��� ����;
ALTER TABLE emp_test DROP (hp_n);

SQL ����
DML : SELECT, INSERT, UPDATE, DELETE ==> Ʈ����� ���� ���� (��� ����.)
DDL : CREATE....., ALTER..., ==> Ʈ����� ���� �Ұ��� (��Ұ� �ȵȴ�.) / �ڵ� Ŀ��

ROLLBACK;

SELECT *
FROM emp_test;

���� ename �� brown ==> sally�� ����
UPDATE emp_test SET ename = 'sally'
WHERE empno = 9999;

�ѹ� �Ǵ� Ŀ���� ����.
ALTER TABLE emp_test ADD (hp NUMBER);

DESC emp_test;

ROLLBACK;

SELECT*
FROM emp_test;

DDL�� �ڵ� Ŀ���̱� ������ DML ���忡�� ������ �޴´�
DDL�� ������ ��� ���� ��� ������ �ߴ� �۾��� ���캼 �ʿ䰡 �ֵ�
SQLD ���迡�� �߳����� ����

