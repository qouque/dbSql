������

��Ģ ������ : +, -, *, / : ���� ������
���� ������ : ?  1==1? true�϶� ���� : false�϶� ����


SQL ������
= : �÷�|ǥ���� = �� -->���� ������

IN : �÷�|ǥ���� IN (����)
    deptno IN (10,30) --> IN (10,30), deptno (10,30) ->�߸���ǥ��
    
EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

���������� ���� ���� ���� ���������� ���� ����� �׻� ���� �ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�.

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� ���� �ʰ� �ߴ�.
���� ���� ���ο� ������ ���� �� ���

SELECT *
FROM emp 
WHERE EXISTS (SELECT 'X'
              FROM dept);

�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 14-KING = 13���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);


IS NOR NULL�� ���ؼ��� ������ ����� ����� �� �� �ִ�.
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

join
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;

--SUB9]
SELECT *
FROM product p
WHERE EXISTS (SELECT *
              FROM cycle c
              WHERE cid = 1
                AND p.pid = c.pid);
                
IN �����ڸ� ���
SELECT *
FROM product p
WHERE p.pid IN (SELECT pid
                FROM cycle c
                WHERE cid = 1);

--SUB10]
SELECT *
FROM product p
WHERE NOT EXISTS (SELECT *
                  FROM cycle c
                  WHERE cid = 1
                    AND p.pid = c.pid);

���տ���
������
(1, 5, 3) U (2,3) = (1,2,3,5)

SQL���� �����ϴ� UNION ALL (�ߺ� �����͸� �Լ� ���� �ʴ´�)
(1, 5, 3) U (2,3) = (1,2,3,5,3)


������
(1, 5, 3) ������ (2,3) = (3)

������
(1, 5, 3) ������ (2,3) = (1, 5)

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ��(��, �Ʒ��� ���� �ȴ�)

UNION ������ : �ߺ�����(������ ������ ���հ� ����)
;
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

UNION ALL ������ : �ߺ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);


INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);


MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698);

SQL ���տ������� Ư¡

���� �̸� : ù�� SQL�� �÷��� ���󰣴�

ù��° ������ �÷��� ��Ī �ο�;
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7369);

2. ������ �ϰ���� ��� �������� ���� ����
   ���� SQL���� ORDER BY �Ұ� (�ζ��� �並 ����Ͽ� ������������ ORDER BY �� ������� ������ ����)

SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY nm, �߰� ������ ���� �Ұ�
UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7698)
ORDER BY nm;

3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���� ����� ����), UNION ALL�� �ߺ� ���

4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
    --> ����ڿ��� ����� �����ִ� �������� ������
        --> UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡��
            �����ϴ�

�˰���(����-��ǰ, ���� ����, ���� ����,....
            �ڷ� ���� : Ʈ������(���� Ʈ��, ������ Ʈ��)
                        heap
                        stack, queue
���տ��꿡�� �߿��� ���� : �ߺ�����
                        
SELECT *
FROM fastfood;

--(����ŷ�� ���� + �Ƶ������� ���� + kfc�� ����)/ �Ե������� ����
SELECT
((SELECT count(gb)
FROM fastfood
WHERE gb = '����ŷ' AND sido = '��⵵' AND sigungu ='���ֽ�'
GROUP BY sido)
+NVL((SELECT count(gb)
FROM fastfood
WHERE gb = '�Ƶ�����' AND sido = '��⵵' AND sigungu ='���ֽ�'
GROUP BY sido), 0)
+NVL((SELECT count(gb)
FROM fastfood
WHERE gb = 'KFC' AND sido = '��⵵' AND sigungu ='���ֽ�'
GROUP BY sido),0))
/(SELECT count(gb)
FROM fastfood
WHERE gb = '�Ե�����' AND sido = '��⵵' AND sigungu ='���ֽ�'
GROUP BY sido) a
FROM dual;

SELECT
    (SELECT count(gb)
    FROM fastfood
    WHERE gb IN ('����ŷ','�Ƶ�����','KFC')
      AND sido  = '��⵵'
      AND sigungu = '���ֽ�') / 
    (SELECT count(gb)
    FROM fastfood
    WHERE gb IN ('�Ե�����')
      AND sido  = '��⵵'
      AND sigungu = '���ֽ�') a
FROM fastfood;



SELECT ROWNUM rank, a.sido, a.sigungu, a.city
FROM
(SELECT bk.sido, bk.sigungu, bk.cnt, mac.cnt, kfc.cnt, lot.cnt, ROUND((bk.cnt + mac.cnt + kfc.cnt)/ lot.cnt,2) city
FROM
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido, sigungu) bk, 
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu) mac, 
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kfc, 
(SELECT sido, sigungu, count(*) cnt
FROM fastfood
WHERE gb = '�Ե�����'
GROUP BY sido, sigungu) lot
WHERE bk.sido = mac.sido
  AND mac.sido = kfc.sido
  AND kfc.sido = lot.sido
  AND bk.sigungu = mac.sigungu
  AND mac.sigungu = kfc.sigungu
  AND kfc.sigungu = lot.sigungu
ORDER BY city desc) a;


SELECT ROWNUM rank, main.*
FROM ( SELECT sido, sigungu, ROUND(count(gb)/NVL((SELECT count(gb)
                                                  FROM fastfood f
                                                  WHERE gb IN ('�Ե�����') 
                                                    AND fastfood.sido = f.sido
                                                    AND fastfood.sigungu = f.sigungu
                                                  GROUP BY sido, sigungu),1) ,2) dosidevelope
       FROM fastfood
       WHERE gb IN ('����ŷ','�Ƶ�����','KFC')
       GROUP BY sido, sigungu
       ORDER BY dosidevelope DESC ) main;


SELECT *
FROM fastfood;


����1]fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL�ۼ�
 1. ���ù��������� ���ϰ�
 2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
 3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
 
 
���� �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������,����û �ñ���, ����û �ñ���, ����û �������� �ݾ�1�δ� �Ű��

����2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺��� 4�����)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ����(fastfood ���̺��� 1���� ���)
CASE, DECODE

����3]
�ܹ��� ���� SQL�� �ٸ����·� �����ϱ�
select *
from tax;

