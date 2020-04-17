/*
-SERLECT ���� ���� : 
    ��¥ ����(+, -) : ��¥ + ����, -���� �� ��¥���� +- �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����(....) : �����ð��� �ٷ��� ����...
    ���ڿ�����
        ���ͷ� : ǥ����
                    ���� ���ͷ� : ���ڷ� ǥ��
                    ���� ���ͷ� : JAVA : "���ڿ�"/ SQL : 'SQL'
                                SELECT SELECT * FROM || table_name
                                SELECT 'SECLECT * FROM' || table_name
                        ���ڿ� ���� ���� : +�� �ƴ϶� ||(java ������ +)
                    ��¥?? : TO_DATE('��¥ ���ڿ�', '��¥ ���ڿ��� ���� ����')
                            TO_DATE('20200417','YYYYMMDD')
                            
- WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����
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

-- sal���� 100���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN, AND
-- �񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
-- ���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����


SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

-- exclusive or (��Ÿ�� or)
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
-- IN ������
- �÷� : Ư���� IN (��1, ��2, ...)
- �÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�ϸ� TRUE
*/

SELECT *
FROM emp
WHERE deptno IN (10, 30);
--> deptno�� 10�̰ų� 30���� ����
-- deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;

--users ���̺��� userid�� brown, cony, sally�� �����͸� ������ ���� ��ȸ �Ͻÿ�(IN ������ ��� --WHERE3--
SELECT userid AS "���̵�", usernm AS "�̸�", alias AS "����"
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

/*
- ���ڿ���Ī ���� : LIKE ���� / JAVA : .startsWith(prefix), .endsWith(suffix)
- ����ŷ ���ڷ� :  % - ��� ���ڿ�(���� ����)
                 _ - � ���ڿ��̵��� �� �ϳ��� ����
- ���ڿ��� �Ϻΰ� ������ TRUE!!

-�÷� : Ư���� LIKE ���� ���ڿ�;

-'cony' : cony�� ���ڿ�
-'co%'  : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� ���ִ� ���ڿ�
          'cony', 'con', 'co'
'%co%'  : co�� �����ϴ� ���ڿ�
          'cony', 'sallt cony'
'co__'(����� 2��) : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �ü� �ִ� ���ڿ�
*/

--���� �̸�(ename)�� �빮�� S�� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--member ���̺��� ȸ���� ���� [��]���� �����mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--�̸��� [��]�� ���� ����� ��ȸ�ϴ� ����
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

/*
NUL ��
SQL �񱳿����� : =
*/

--MGR �÷� ���� ���� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr = NULL;

-- SQL ���� NULL ���� ���� ��� �Ϲ����� �񱳿�����(=)�� ��� ���ϵ�
-- IS �����ڸ� ���

SELECT *
FROM emp
WHERE mgr IS NULL;

/*
- ���� �ִ� ��Ȳ���� � �� =, !=, <>
NULL : IS NULL, IS NOT NULL
*/

-- emp ���̺��� mrg �÷� ���� NULL�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

-- emp ���̺��� ��(comm)�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��Ͻÿ�.
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

--IN�����ڸ� �񱳿����ڷ� ����
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
--emp ���̺��� job�� SALESMAN�̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('19810601', 'YYYYMMDD')
  AND sal > 1300;
-- Ű���� ���ؼ��� ��ҹ��� ������ ��������, ������ ���� ��ҹ��� ������ �Ѵ� ����!!

-- WHERE 8]
-- emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
-- (IN, NOT IN ������ ������)
SELECT *
FROM emp
WHERE deptno != 10 
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');
--(NOT IN ������ ���)
SELECT *
FROM emp
WHERE deptno NOT IN 10 
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--WHERE 10]
--emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� 1981�� 6�� 1�� ���Ŀ� �Ի� ������ ������ ��ȸ
--(�� �μ���ȣ�� 10, 20, 30���� �ִٰ� �����ϰ� IN�����ڸ� ���)
SELECT *
FROM emp
WHERE deptno IN (20,30)
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--WHERE 11]
--enp ���̺��� job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ��ȸ�Ͻÿ�
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--WHERE 12]
--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%'; --empno���̺��� number, ����ȯ�� �߻�
-- '78%'�� LIKE�� ���� ���

--WHERE 13]
--
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno = 78
   OR empno >= 780 AND empno < 790
   OR empno >= 7800 AND empno < 7900;

/*
- ������ �켱����
1. ���������(+,-,...)
2. ���ڿ�����(||)
3. �񱳿���(=, <=, >=, ...)
4. IS,[NOT]NULL, LIKE, [NOT] IN
5. [NOT] BETWEEN
6. NOT
7. AND
8. OR
*/

--WHERE 14]
--emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6�� 1�� ������ ����� ������ ��ȸ
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
   OR empno LIKE '78%'
  AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

/*
- ���� : [a, b, c] == [a, c, b]
- table���� ��ȸ, ����� ������ ����(������������)
==> ���нð��� ���հ� ������ ����

SLQ������ �����͸� �����Ϸ��� ������ ������ �ʿ�.
--ORDER BY �÷��� [��������], �÷���2 [��������], ...

������ ���� : ��������(DEFALLT) - ASC, �������� - DESC
*/

--���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename ASC;

--���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename DESC;
--job�� �������� �������������ϰ� job�� ������� �Ի����ڷ� �������� ����
--��� ������ ��ȸ
SELECT *
FROM emp
ORDER BY job ASC, hiredate DESC;





