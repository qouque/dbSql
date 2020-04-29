
OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �ɷ��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<===> INNER JOIN (�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp���̺��� �÷��� mgr �÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó����
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�

������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�
--> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ�
    KING�� ������ ������ �ʴ´�. (emp ���̺� �Ǽ� 14�� ---> ���� ��� 13��)
SELECT m.empno mgr_no, m.ename mgr_name ,
       emp.empno emp_no, emp.ename emp_name
FROM emp, emp m
WHERE emp.mgr = m.empno;

SELECT m.empno mgr_no, m.ename mgr_name ,
       emp.empno emp_no, emp.ename emp_name
FROM emp JOIN emp m ON (emp.mgr = m.empno);

���� ������ OUTER �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������,
 ������ ����� ������ ���� ������ ������ �ʴ´�);
 
ANSI-SQL : OUTER
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACEL=SQL : OUTER
oracle join
1. FROM���� ������ ���̺� ���(�޸��� ����)
2. WHERE ���� ���� ������ ��� 
3. ���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ��ش�
    --> ������ ���̺� �ݴ��� �� ���̺��� �÷�
    
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �Ҽ� �μ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON ���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno = 10);

������ WHERE ���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE e.deptno = 10;

OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e ,emp m 
WHERE e.mgr = m.empno(+)
  AND e.deptno = 10;

outerjoin1]

SELECT *
FROM buyprod;
WHERE buy_date = TO_DATE('2005/1/25', 'YYYY/MM/DD');

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod
  ON (buyprod.buy_prod = prod.prod_id 
 AND buy_date = TO_DATE('2005/1/25', 'YYYY/MM/DD'));
 
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod , buyprod 
WHERE buyprod.buy_prod(+) = prod.prod_id
  AND buy_date(+) = TO_DATE('2005/1/25', 'YYYY/MM/DD');



--OUTER JOIN 2]

SELECT TO_DATE('2005/1/25', 'YYYY/MM/DD') buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod , buyprod 
WHERE buyprod.buy_prod(+) = prod.prod_id
  AND buy_date(+) = TO_DATE('2005/1/25', 'YYYY/MM/DD');

--OUTER JOIN 3]
SELECT TO_DATE('2005/1/25', 'YYYY/MM/DD') buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
FROM prod , buyprod 
WHERE buyprod.buy_prod(+) = prod.prod_id
  AND buy_date(+) = TO_DATE('2005/1/25', 'YYYY/MM/DD');

--OUTER JOIN 4]
ORACLE-SQL : ;
SELECT p.pid, pnm, NVL(cid,1) cid, NVL(day,0) day, NVL(cnt,0) cnt
FROM cycle c, product p
WHERE c.pid(+) = p.pid
  AND cid(+) = 1;

ANSI-SQL : ;
SELECT p.pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0) cnt
FROM cycle c RIGHT OUTER JOIN product p
  ON( c.pid = p.pid AND cid = 1);

--OUTER JOIN5]
SELECT a.pid, a.pnm, a.cid, cnm, a.day, a.cnt
FROM customer cu JOIN
     (SELECT p.pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0) cnt
      FROM cycle c RIGHT OUTER JOIN product p
      ON( c.pid = p.pid AND cid = 1)) a 
    ON (cu.cid = a.cid);

SELECT p.pid, p.pnm, NVL(c.cid,1), cnm, day, cnt
FROM customer c, cycle, product p 
WHERE cycle.pid(+) = p.pid
  AND c.cid(+) = cycle.cid
  AND c.cid(+) = 1;


15-->45
3�� --> customer ���̺��� ���� ����
SELECT *
FROM product, cycle, customer
WHERE product.pid = cycle.pid;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ �������� ����� ��ȸ�ȴ�.

emp 14 * dept 4 = 56

ANSI-SQL
SELECT *
FROM emp CROSS JOIN dept;

ORACLE-SQL : ���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�.;
SELECT *
FROM emp , dept;

---crossjoin 1]
ANSI-SQL ;
SELECT *
FROM customer CROSS JOIN product;

ORACLE-SQ; ;
SELECT *
FROM customer, product;

��������
WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ����
SELECT *
FROM emp
WHERE 1  = 1
   OR 1 != 1;

���� <--> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT
    SCALAR SUB QUERY
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�
    EX) dual���̺�
    
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��
    
3. WHERE
    SUB QUERY
    WHERE ���� ���� ����
    
SMITH�� ���� �μ� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������??
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

 -> �������� 2���� ������ ���� ����
    �ֹ�° ������ ù��°�� ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�
    (SMITH(20) -> WARD(30) -> �ι�° ���� �ۼ��� 10������ 30������ ������ ����
    -> �������� ���鿡�� ���� ����)

ù��° ����;
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

�ι�° ����;
SELECT *
FROM emp
WHERE deptno = 20;

���������� ���� ���� ����

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = :ename);


-- SUB 1]
SELECT count(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

-- sub 2]
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);













