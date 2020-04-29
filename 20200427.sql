SELECT count(*)
from
    (SELECT deptno
    FROM emp
    GROUP BY deptno);
--->���� �Ѱ�

dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�系�� �����ϴ� ��� �μ�����
emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10, 20, 30 ==>3��

DBMS : DataBase Managmeny System
  ==> db
RDBMS : Relational DataBase Managmeny System
  ==> ������ �����ͺ��̽�
        80�� �ʹ�

JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �� �� �ִ� �÷��� ������ ��������(���� Ȯ��)

���տ��� ==> ���� Ȯ�� (���� ��������.)

NATURAL JOIN 
    . �����Ϸ��� �� ���̺��� ����� �÷��� �̸��� ���� ���
    . emp, dept ���̺��� deptno��� �����(������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
    . �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������ ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����

. emp ���̺� : 14��
. dept ���̺� : 4��


���� �Ϸ����ϴ� �÷��� ���� ������� ����
SELECT *
FROM emp NATURAL JOIN dept;
-- �����̺��� �̸��� ������ �÷����� �����Ѵ�.
    ==>deptno

ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
 1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
 2. ����� ������ WHERE���� ����ϸ� �ȴ�.  (ex : WHERE emp.deptno = dept.deptno)
 
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno�� 10���� �����鸸 ��ȸ

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno 
  AND emp.deptno = 10;

ANSI-SQL : JOIN with USING
    . JOIN �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
    . �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���
    
SELECT *
FROM emp JOIN dept USING (deptno);


ANSI-SQL : JOIN with ON
    . ���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
    . ON���� ����� ������ ���;
    
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


ORACLE �������� �� SQL�� �ۼ�

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;



JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
EMP ���̺��� ������ �������� ������ ��Ÿ���� ������ ������ mgr �÷��� �ش� ������ ������ ����� ����.
�ش� ������ �������� �̸��� �˰���� ��

ANSI-SQL�� SQL ���� : 
�����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
              ����� �÷� : ����.MGR = ������.EMPNO
              ==> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
                    ==> NATURAL JOIN, JOIN WITH USING�� ����� �Ұ����� ����
                        ==> JOIN with ON


SELECT *
FROM emp JOIN emp a ON (emp.mgr = a.empno);

NONEQUI JOIN : ����� ������ =�� �ƴҶ�

�׵��� WHERE���� ����� ������ : =. !=, <>, <=,<,>,>=
                            AND, OR, NOT
                            LIKE %,_
                            OR - IN
                            BETWEEN ==>  >=, <=
                            
SELECT *
FROM emp;

SELECT *
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);


==> ORACLE ���� �������� ����

SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--join0
����Ŭ JOIN���;
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY emp.deptno;

ANSI-SQL ��� : JOIN with ON;
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept on (emp.deptno = dept.deptno)
ORDER BY emp.deptno;

ANSI-SQL ��� : JOIN with USING;
SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING (deptno)
ORDER BY deptno;

--JOIN0_1
����Ŭ JOIN���;
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND (emp.deptno = 10 OR dept.deptno =30);

ANSI-SQL��� : JOIN with ON;
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.deptno = 10 OR dept.deptno = 30;

ANSI-SQL��� : JOIN with USING;
SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING (deptno)
WHERE deptno = 10 OR deptno =30;

--JOIN0_2
����Ŭ JOIN���;
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal > 2500;

ANSI-SQL��� : JOIN with ON;
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE emp.sal > 2500;

ANSI-SQL��� : JOIN with ON;
SELECT empno, ename, sal, deptno, dname
FROM emp JOIN dept USING (deptno)
WHERE emp.sal > 2500;

JOIN0_3~4 ����]
--3
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND (emp.sal > 2500
  AND emp.empno >7600);

--4
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND (emp.sal > 2500
  AND emp.empno >7600)
  AND dept.dname = 'RESEARCH';

SELECT *
FROM emp, dept
WHERE emp.deptno != dept.deptno;


SELECT *
FROM prod;

SELECT *
FROM lprod;

�ǽ� join 1]; ����
SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);







