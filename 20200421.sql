SELECT SUBSTR('Hello, World', 1, 5) sub, 
       LENGTH('Hello, World') len,
       INSTR('Hello, World', 'o') ins,
       INSTR('Hello, World', 'o', 6) ins2,
       INSTR('Hello, World', 'o', INSTR('Hello, World', 'o') + 1) ins3,
       LPAD('hello', 15, '*') lp,
       RPAD('hello', 15) rp,
       REPLACE('Hello, World', 'll', 'LL') rep,
       TRIM('     Hello     ') tr,
       TRIM('H' FROM 'Hello') tr2 /*������*/
FROM dual;

/*
NUMBER ���� �Լ�
ROUND(����, [�ݿø� ��ġ - defualt : 0]) : �ݿø�
    - ROUND(105.54, 1) : �Ҽ��� ù��° �ڸ����� ����� ���� ==? �Ҽ��� �ι�° �ڸ����� �ݿø� = 105.5
TRUNC(����, [���� ��ġ - defualt : 0]) : ����
MOD(������, ����) : ����������
*/
SELECT  ROUND(105.54, 1) round,
        ROUND(105.55, 1) round2,
        ROUND(105.55, 0) round3,
        ROUND(105.55, -1) round4,
        ROUND
FROM dual;

SELECT  TRUNC(105.54, 1) trunc,
        TRUNC(105.55, 1) trunc2,
        TRUNC(105.55, 0) trunc3,
        TRUNC(105.55, -1) trunc4
FROM dual;

SELECT MOD(10,3)
FROM dual;

SELECT MOD(10,3), sal, MOD(sal, 1000)
FROM emp;

/*
��¥ ���� �Լ�
- SYSDATE : ������� ����Ŭ ������ ���̽� ������ ���� �ð�, ��¥�� ��ȯ�Ѵ�.
            �Լ������� ���ڰ� ���� �Լ�
            (���ڰ� ���� ��� JAVA : �޼ҵ�()
                            SQL : �Լ���

- date type +- ���� : ���� ���ϱ� ����
 ���� 1 = �Ϸ�
 1/24 = 1 �ð�
 1/24/60 = 1 ��
 
- ���ͷ�
 ���� : 1,2,3,4
 ���� : ''
 ��¥ : TO_DATE('��¥ ���ڿ�', '����')
*/

SELECT SYSDATE, SYSDATE + 5
FROM dual;

--fn 1]
SELECT TO_DATE('20191231', 'YYYYMMDD') lastday,
       TO_DATE('20191231', 'YYYYMMDD')-5 lastday_before5,
       SYSDATE now,
       SYSDATE -3 now_before3
FROM dual;

/*
TO_DATE(���ڿ�, ����) : ���ڿ��� ���˿� �°� �ؼ��Ͽ� ��¥ Ÿ������ ����ȯ
TO_CHAR(��¥, ���) : ��¥Ÿ���� ���信 �°� ���ڿ��� ��ȯ
YYYY : �⵵
MM : ��
DD : ����
D : �ְ�����(1~7,1-������, 2-������, ... , 7-�����)
IW : ����(52~53)
HH : �ð�(12�ð�)
HH24 : 25�ð� ǥ��
MI : ��
SS : ��
*/

--����ð�(SYSDATE) �ú��� �������� ǥ�� ==> TO_CHAR�� �̿��Ͽ� ����ȯ
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
       TO_CHAR(SYSDATE, 'd') d,
       TO_CHAR(SYSDATE - 3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
       TO_CHAR(SYSDATE - 1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1Hour
FROM dual;

--fn 2]
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') dt_dash_with_time,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy
FROM dual;

/*
- MONTHS_BETWEEN(DATE1, DATE2) : DATE1�� DATE2������ �������� ��ȯ
    4���� ��¥ �����Լ��߿� ���󵵰� ����
*/

SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21','YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD')),
       MONTHS_BETWEEN(TO_DATE('2020/04/22','YYYY/MM/DD'), TO_DATE('2020/03/21','YYYY/MM/DD'))
FROM dual;

/*
-ADD_MONTHS(DATE1, ������ ������) : DATE1�� ���� �ι�° �Էµ� ������ ��ŭ ������ DATE
*/

--���� ��¥�κ��� 5���� ��
SELECT ADD_MONTHS(SYSDATE, 5) dt,
       ADD_MONTHS(SYSDATE, -5) dt2
FROM dual;

/*
- NEXT_DAY(date1, �ְ�����) : date1���� �����ϴ� ù��° �ְ������� ��¥�� ��ȯ
*/
SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

/*
- LAST_DAY(DATE1) DATE1�� ���� ���� ������ ��¥�� ��ȯ
SYSDATE : 2020/04/21 --> 2020/04/30
*/
SELECT LAST_DAY(SYSDATE)
FROM dual;

--��¥�� ���� ���� ù��° ��¥ ���ϱ�(1��)
--SYSDATE�� ���� ��������� ���ڿ� ���ϱ�
SELECT SYSDATE,
       ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
       TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD')
FROM dual;







