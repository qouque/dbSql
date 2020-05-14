
CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1=1;

CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2 (dname); 
CREATE INDEX idx_dept_test2_02 ON dept_test2 (deptno); 
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno,dname);

DROP INDEX idx_u_dept_test2_01;
DROP INDEX  idx_dept_test2_02;
DROP INDEX  idx_dept_test2_03;

CREATE INDEX idx_emp_01 ON emp (empno); 
CREATE INDEX idx_emp_02 ON emp (ename); 
CREATE INDEX idx_emp_03 ON emp (deptno, mgr);

DROP INDEX idx_emp_05;

EXPLAIN PLAN FOR
SELECT b.*
FROM emp a, emp b
WHERE a.mgr = b.empno
  AND a.deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

�����ð��� ��� ����
==> ���� ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� �����̵Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ�
             ���� ������ ��� ����� ���� ���εǴ� ���� ���
self join : ���� ���̺� ���� ���� �ϴ� ����

�����ڰ� DMBS�� SQL�� ���� ��û �ϸ� DBMS�� SQL�� �м��ؼ�
��� �� ���̺� ������ ���� ����, 3���� ����� ���ι��(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

OnLine Transaction Processing : �ǽð� ó��
                                ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
OnLine Analysis Processing : �ϰ�ó�� 
                                ==> ��ü ó���ӵ��� �߿� �� ���(���� ���� ���, ���� �ѹ��� ���)












