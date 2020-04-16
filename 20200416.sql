SELECT *    --��� �÷������� ��ȸ
FROM prod;   --�����͸� ��ȸ�� ���̺� ���

/*
 - Ư�� �÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2...
 - prod_id, prod_name�÷��� prod ���̺��� ��ȸ
*/

SELECT prod_id,prod_name
FROM prod;

--SELECT 1
--lprod ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ�
SELECT *
FROM lprod;
-- buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ�ϴ� ������ �ۼ�
SELECT buyer_id, buyer_name
FROM buyer;
-- cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ�
SELECT *
FROM cart;
-- member ���̺��� mem_id, mem_pass, mem_name �÷��� ��ȸ�ϴ� ������ �ۼ�
SELECT mem_id, mem_pass, mem_name
FROM member;

--

/*
-SQL ���� : JAVA�� �ٸ��� ���� X, �Ϲ��� ��Ģ����
int b = 2; = ���� ������, == ��
SQL ������ Ÿ�� : ����, ����, ��¥(date)
users ���̺��� (4/14 ����� ����) ����
users ���̺��� ��� �����͸� ��ȸ
*/

--��¥ Ÿ�Կ� ���� ���� : ��¥�� +, - ���� ����
-- date type + ���� : date ���� ������¥��ŭ �̷� ��¥�� �̵�
-- date type - ���� : date ���� ������¥��ŭ ���� ��¥�� �̵�

SELECT userid,reg_dt, reg_dt + 5 after_5days, reg_dt - 5 
FROM users;
/*
- �÷� ��Ī : ���� �÷����� ���� �ϰ� ���� ��
- systax : ���� �÷��� [as] ��Ī��Ī
- ��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ""(���� �����̼�)���� ���´�.
- ���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ��� ���� �����̼��� ����Ѵ�.
*/

SELECT userid as id, userid id2, userid "�� �� ��" 
FROM users;

--�ǽ� SELECT2
--prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ�
--(�� prod_id ->id, prod_name -> name���� �÷� ��Ī�� ����)
SELECT prod_id id, prod_name name
FROM prod;
--lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ�
--(��, lprod_gu -> gu, lprod_nm -> m,���� �÷� ��Ī�� ����
SELECT lprod_gu gu, lprod_nm nm
FROM lprod;
--buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ�
--(�� buyer_id -> ���̾���̵�, buyer_name -> �̸� ���� �÷���Ī ����
SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;

--���ڿ� ����(���տ���) : || (���ڿ� ������ + �����ڰ� �ƴϴ�)
SELECT /*userid + 'test'*/ userid || 'test', reg_dt + 5, 'test', 15
FROM users;
--�� �̸� ��
SELECT '�� ' || userid || ' ��'
FROM users;

SELECT userid, usernm, userid || usernm
FROM users;

SELECT userid || usernm as id_name, 
       CONCAT(userid, usernm) as concat_id_name
FROM users;

--sel_con1
--user_tables : oracle���� �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view) --> data dictionary
SELECT table_name 
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' AS qeury
FROM user_tables;

SELECT * FROM LPROD;
SELECT * FROM BUYER;
SELECT * FROM PROD;
SELECT * FROM BUYPROD;
SELECT * FROM MEMBER;
SELECT * FROM CART;
SELECT * FROM RANGER;
SELECT * FROM RANGERDEPT;
SELECT * FROM BONUS;
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM SALGRADE;
SELECT * FROM USERS;

/*
���̺��� ���� �÷��� Ȯ���ϴ� ���
1. tool(sql developer)�� ���� Ȯ��
   ���̺� - Ȯ���ϰ��� �ϴ� ���̺�
2. SELECT *
   FROM ���̺�
   �ϴ� ��ü ��ȸ --> ��� �÷��� ǥ��
3. DESC ���̺��
4. data dictionary : user_tab_columns
*/

DESC emp;

SELECT *
FROM user_tab_columns;

/*
-- ���� ���� ��� SELECT ���� --
��ȸ�ϰ��� �ϴ� �÷� ��� : SELECT
��ȸ�� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
---WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ---
*/

/*
java�� �� ���� : a������ b������ ���� ������ �� ==
sql �� �� ���� : =
*/

SELECT *
FROM users
WHERE 1 = 2;

--emp���̺��� �÷��� ������ Ÿ���� Ȯ��
DESC emp;

SELECT *
FROM emp;
/*
- emp : employee
- empno : �����ȣ
- ename : ��� �̸�
- job : ������(��å)
- mgr : �����(������)
- hiredate : �Ի�����
- sal : �޿�
- comm : ������
- deptno : �μ���ȣ
*/

SELECT *
FROM dept;

--emp ���̺��� ������ ���� �μ���ȣ�� 30������ ū �μ��� ���� ������ ��ȸ;

SELECT *
FROM emp
WHERE deptno >= 30;

-- != �ٸ���
-- user ���̺��� ����� ���̵�(userid)�� brown�� �ƴ� ����ڸ� ��ȸ

SELECT *
FROM users
WHERE userid != 'brown';

/*
--SQL ���ͷ�--
- ���� : ...20,30.5
- ���� : �̱� �����̼� : 'hello world'
- ��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ����')
*/

--1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
-- emp ���̺��� ���� : 14��
-- 1982�� 1�� 1�� ���� �Ի��� : 3��
-- 1982�� 1�� 1�� ���� �Ի��� : 11��
SELECT *
FROM emp
WHERE hiredate <= TO_DATE('1982/01/01','YYYY/MM/DD'); 
-- / �� �������� ��)WHERE hiredate >= TO_DATE('19820101','YYYYMMDD');
-- / �� .���� �ٲܼ� ���� ��)WHERE hiredate >= TO_DATE('1982.01.01','YYYY.MM.DD');





