NULLó�� �ϴ� ���(4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
NVL, NVL2....

condition : CASE, DECODE

�����ȹ : �����ȹ�� ����
          ���� ����;
          
          emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 ->5)
�ش� ������ job�� MANAGER�̸鼭 deptno��10�̸� SAL���� 30% �λ�� �ݾ��� ���ʽ��� ����
                                     �׿��� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� SAL��ŭ ����(DECODE�� �̿�)
 

SELECT empno, ename, job,deptno, sal,
       DECODE(job,
              'SALESMAN', sal*1.05, 
              'MANAGER', DECODE(deptno, 10, sal*1.30, sal*1.10),
              'PRESIDENT', sal*1.20,
              sal) bonus
FROM emp;

���� A = {10, 15, 18, 23, 24, 25 ,29, 30, 35, 27}
�Ҽ� : {23, 29, 37} COUNT -3. ,MAX-37, MIN-23, AVG-29.66, SUM-89
��Ҽ� : {10, 14, 18, 24, 25, 30, 35};


GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���ΰ�.
EX : �μ��� �޿� ���
    EMP ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.

GROUP BY ����� ���� ���� : SELECT ����� �� �ִ� �÷��� ���ѵ� �߿�~

SELECT �׷��� ���� �÷�, �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY ];

�μ����� ���� ���� �޿� ��

SELECT deptno, 
       MAX(sal), --�μ����� ���� ���� �޿� ��
       MIN(sal), --�μ����� ���� ���� �޿� ��
       ROUND(AVG(sal), 2), --�μ��� �޿� ���
       SUM(sal), --�μ��� �޿� ��
       COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
       COUNT(*), --�μ��� ���� ��
       COUNT(mgr)
FROM emp
GROUP BY deptno;

SELECT deptno, ename, MAX(sal) -- GROUP BY ���� ���� �÷��� ���ð�� ���� (�������� ���� �ʴ´�.)
FROM emp
GROUP BY deptno;

* �׷� �Լ��� ���� �μ���ȣ ���� ���� ���� �޿��� ���� ���� ������
  ���� ���� �޿��� �޴� ����� �̸��� �� �� ����
    ===> ���� WINDOW FUNCTION�� ���� �ذ� ����

emp ���̺��� �׷������ �μ���ȣ�� �ƴ� ��ü �������� �����ϴ� ���
SELECT MAX(sal), --��ü ������ ���� ���� �޿� ��
       MIN(sal), --��ü ������ ���� ���� �޿� ��
       ROUND(AVG(sal), 2), --��ü ������ �޿� ���
       SUM(sal), --��ü ������ �޿� ��
       COUNT(sal), --��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
       COUNT(*), --��ü ���� ��
       COUNT(mgr) -- mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp;


GROUP BY ���� ����� �÷���
SELECT ���� ������ �ʾƵ� �����
��.
GROUP BY ���� ������� ���� �÷���
SELECT ���� ������ ����

�׷�ȭ�� ���þ��� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ֵ�(���� �ƴ�);
SELECT deptno, 'TEST', 1,
       MAX(sal), --�μ����� ���� ���� �޿� ��
       MIN(sal), --�μ����� ���� ���� �޿� ��
       ROUND(AVG(sal), 2), --�μ��� �޿� ���
       SUM(sal), --�μ��� �޿� ��
       COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
       COUNT(*), --�μ��� ���� ��
       COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP �Լ� ������ NULL ���� ���ܰ� �ȴ�
30�� �μ����� NULLL���� ���� ���������� SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�.;
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10, 20�� �μ��� SUM(COMM)�÷��� NULL�� �ƴ϶� 0�� �������� NULLó��;
* Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����

NVL(SUM(comm),0) : COMM�÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm,0)) : ��� COMM�÷��� NVL�Լ��� ������ (�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, SUM(NVL(comm,0)) SUM1, NVL(SUM(comm),0) SUM2
FROM emp
GROUP BY deptno;

single row �Լ��� where ���� ����� �� ���
multi row �Լ�(group�Լ�)�� where���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� where ������ ��� ����
SELECT *
FROM emp
WHERE LOWER(ename) ='smith';

�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ

SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 5000      ---> ����
GROUP BY deptno;


SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--grp1 
SELECT  
       MAX(sal) max_sal,
       MIN(sal) min_sa,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       count(sal) count_sal,
       count(mgr) count_mgr,
       count(*) count_all
FROM emp;

--grp2
SELECT deptno,
       MAX(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       count(sal) count_sal,
       count(mgr) count_mgr,
       count(*) count_all
FROM emp
GROUP BY deptno;

--grp3] *����
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES') dname,
       MAX(sal) max_sal,
       MIN(sal) min_sal,
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal) sum_sal,
       count(sal) count_sal,
       count(mgr) count_mgr,
       count(*) count_all
FROM emp
GROUP BY deptno
ORDER BY MAX(sal) DESC;

SELECT *
FROM emp;

----�ǽ� 4
SELECT hire_yyyymm,
       count(hire_yyyymm) cnt
FROM       
    (SELECT TO_CHAR(hiredate,'YYYYMM') hire_yyyymm
     FROM emp)
GROUP BY hire_yyyymm;


SELECT TO_CHAR(hiredate,'YYYYMM') hire_yyyymm,
      count(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');

-- �ǽ� 5
SELECT TO_CHAR(hiredate,'YYYY') hire_yyyy,
      count(hiredate) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');


----�ǽ� 6
SELECT
    count(*) cnt
FROM dept;

SELECT *
FROM dept;

--�ǽ� 7
SELECT *
FROM emp;

SELECT count(dept)
from
    (SELECT count(deptno) dept
    FROM emp
    GROUP BY deptno);

