�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex : ��ü ������ �޿� ���, SMITH ������ ���� �μ��� �μ���ȣ

WHERE���� ��밡���� ������ 
WHERE deptno = 10
-->
�μ���ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno IN (10,20)
WHERE deptno - 10 OR deptno = 30


������ ������
�������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ� 
WHERE deptno IN (�������� �����ϰ�, �ϳ��� �÷����� �̷���� ����);

SMITH = 20, ALLEN�� 30�� �μ��� ����

SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ;


���� ��������, �÷��� �ϳ��� 
----> ������������ ��밡���� ������ IN(���� ��, �߿�), (ANY, ALL)

WHERE �÷� : ǥ���� IN (��������)
IN : ���������� ������� ������ ���� ���� �� TRUE
    WHERE �÷� : ǥ���� IN (��������)
ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
    WHERE �÷� : ǥ���� ANY (��������)
ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
    WHERE �÷� : ǥ���� ALL (��������)

SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �ΰ��� ������ ����
[1-1] SMITH, ALLE�� ���� �μ��� �μ���ȣ�� Ȯ�� �ϴ� ����
SELECT *
FROM emp
WHERE ename IN ('SMITH', 'ALLEN');

[1-2] 1-1]���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno IN (20,30);

--> ���������� �̿��ϸ� �ϳ��� sql���� ���డ��
;
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'ALLEN'));

--sub3
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

ANY, ALL
SMITH(800)�� WARD(1250) �λ���� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
--> sal < 1250

SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));

SMITH(800)�� WARD(1250) �λ���� �޿����� AKSGDMS �޿��� �޴� ���� ��ȸ
--> sal > 800

SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));

IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30,�� ���
WHERE deptno IN(20,30)

�ҼӺμ��� 20, Ȥ�� 30�� ������ ���� ���
WHERE deptno NOT IN(20,30)

NOT IN �����ڸ� ����Ұ�� ������� ���� NULL�� �ִ��� ���ΰ� �߿�


SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE MGR IS NOT NULL);

NULLó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr,-1)
                    FROM emp)


���� �÷��� �����ϴ� ���������� ���� ���� ---> ���� �÷��� �����ϴ� ������;
PAIRWISE ���� (������) --> ���ÿ� ����
;

SELECT empno, mgr, deptno
FROM emp
WHERE empno IN (7499,7782);

7499, 7782����� ������ ���� �μ�, ���� �Ŵ����� ��� ���� ���� ��ȸ
�Ŵ����� 7698�̸鼭 �ҼӺμ��� 30�� ���
�Ŵ����� 7839�̸鼭 �ҼӺμ��� 10�� ���

mgr �÷��� deptno �÷��� �������� ����
(mgr, deptno)
(7698, 10)
(7698, 30)
(7839, 10)
(7839, 30)
;
SELECT *
FROM emp
WHERE mgr IN (7698, 7839)
  AND deptno IN (10, 30);

PAIRWISE ���� (���� �������� ����� �Ѱ� ����)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499,7782));


�������� ���� - �����ġ
SELECT - ��Į�� ��������
FROM - �ζ��� ��
WHERE - ��������

�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
    ���� �÷�(��Į�� ���� ����)
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����);
    ���� �÷�
    
��Į�� ��������
SELECT ���� ǥ���Ǵ� ���� ����
������ ���� �÷��� �����ϴ� ���������� ��� ����
���� ������ �ϳ��� �÷� ó�� �ν�;

SELECT 'X' ,(SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� ��, �ϳ��� �÷��� ��ȯ �ؾ� �Ѵ�.

���� �ϳ����� �÷��� 2������ ����
SELECT 'X', (SELECT empno, ename FROM emp WHERE ename = 'SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� --> ����
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �˼��� ���� -- > ����
Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����;
SELECT dname
FROM dept
WHERE deptno = 10;

join���� ����
SELECT empno, ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


�� ������ ��Į�� ���������� ����
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) -- dname
FROM emp;

�������� ���� - ���� ������ �÷��� ���� �������� ����ϴ��� ���ο� ���� ����
��ȣ���� ��������(corelated sub query)
    .���� ������ ���� �Ǿ�� ���� ������ ������ �����ϴ�
    
���ȣ ���� ��������(non corelated sub query)
    . main ������ ���̺��� ���� ��ȸ �� ���� �ְ�
      sub ������ ���̺��� ���� ��ȸ �� ���� �ִ�
      --> ����Ŭ�� �Ǵ� ���� �� ���ɻ� ������ �������� ���� ������ ����

��� ������ �޿���� ���� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ� �ϼ���(���� ���� �̿�)

SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?

������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
��ü ������ �޿� ��� --> ������ ���� �μ��� �޿� ���

Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;


SELECT *
FROM emp a
WHERE SAL > (SELECT AVG(sal)
             FROM emp
             WHERE deptno = a.deptno);


SELECT *
FROM dept;

INSERT INTO dept VALUES (99, 'ddit', 'dajeon');

---
emp���̺� ��ϵ� �������� 10,20,30�� �μ����� �Ҽ��� �Ǿ�����
���� �Ҽӵ��� ���� �μ� : 40, 99

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

������ ���� �μ����� ��ȸ(������ �Ѹ��̶� �����ϴ� �μ�)

SELECT *
FROM dept
WHERE deptno IN (SELECT deptno
                 FROM emp);

���������� �̿��Ͽ� in�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� ������ ��
���� ������ �־ �걤 ����(����)

WHERE deptno IN (10,10,10)
WHERE deptno = 10
   OR deptno = 10
   OR deptno = 10;

������ �μ���ȣ�� ������������ ��ȸ���� �ʵ��� ���� �ҷ��� �׷� ������ �� ��� (���� ����)
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                     GROUP BY deptno);


--sub5
SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);


---sub6]
1�� ���� ������ǰ ������ ��ȸ�� �Ѵ�.
�� 2������ �Դ� ���� ��ǰ�� ��ȸ�� �Ѵ�.

1) 1�� ���� �Դ� ������ǰ����
SELECT pid
FROM cycle
WHERE cid = 1;

2) 2�� ���� �Դ� ������ǰ����
SELECT pid
FROM cycle
WHERE cid = 2;


              
SELECT *
FROM cycle c
WHERE pid IN (SELECT pid
              FROM cycle
              WHERE cid = 2)
  AND cid = 1;


---sub7]
������ �̿��� ���
SELECT c.cid, cnm, pnm, day, cnt
FROM customer, product ,(SELECT *
                         FROM cycle c
                         WHERE cid = 1
                           AND pid IN (SELECT pid
                                       FROM cycle
                                       WHERE cid = 2)) c
WHERE c.cid = customer.cid
  AND c.pid = product.pid;
2��° ��� 9����)
SELECT cycle.cid, cnm, pnm, day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
  AND cycle.cid = customer.cid
  AND cycle.pid = product.pid
  AND cycle.pid IN (SELECT pid
                    FROM cycle
                    WHERE cid = 2);




��Į�� ��������
SELECT cid,(SELECT cnm FROM customer WHERE cid = c.cid) cnm,
       pid,(SELECT pnm FROM product WHERE pid = c.pid) pnm, day, cnt
FROM cycle c
WHERE pid IN (SELECT pid
              FROM cycle
              WHERE cid = 2)
  AND cid = 1;



SELECT *
FROM customer;

SELECT *
FROM product;





