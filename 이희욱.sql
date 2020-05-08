����1]fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL�ۼ�
 1. ���ù��������� ���ϰ�
 2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
 3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�

���� �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������,����û �ñ���, ����û �ñ���, ����û �������� �ݾ�1�δ� �Ű��

SELECT a.*, b.*
FROM
    (SELECT ROWNUM rank, a.sido, a.sigungu, a.city
     FROM
        (SELECT bk.sido, bk.sigungu, bk.cnt, mac.cnt, kfc.cnt, lot.cnt,
                ROUND((bk.cnt + mac.cnt + kfc.cnt)/ lot.cnt,2) city
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
    ORDER BY city desc) a) a,
    (SELECT ROWNUM rank, a.*
     FROM
        (SELECT sido, sigungu, ROUND(sal/people,2) avg
         FROM tax
         ORDER BY avg DESC) a) b
WHERE a.rank = b.rank;

����2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺��� 4�����)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ����(fastfood ���̺��� 1���� ���)
CASE, DECODE

SELECT ROWNUM rank, a.*
FROM
    (SELECT sido, sigungu, NVL(ROUND(sum(other)/sum(lot),2),0) city
     FROM
            (SELECT sido, sigungu, gb,
                case
                    WHEN gb IN('�Ե�����') THEN NVL(count(*), 0)
                END lot,
                case
                    WHEN gb IN('����ŷ', '�Ƶ�����', 'KFC') THEN count(*)
                END other
             FROM fastfood 
             GROUP BY sido, sigungu, gb)
     GROUP BY sido, sigungu
     ORDER BY city DESC) a;

���� �ܹ������� �ּ�(�����̽�, ������ġ �����ϰ� ���)
SELECT ROWNUM rank, sido, sigungu, city
FROM
(SELECT sido, sigungu, ROUND((kfc + mac + bk) /lot , 2) city
FROM
(SELECT sido, sigungu,
       NVL(SUM(CASE WHEN gb = '�Ե�����' THEN 1 END),1) lot, NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END),0) kfc,
       NVL(SUM(CASE WHEN gb = '����ŷ' THEN 1 END),0) bk, NVL(SUM(CASE WHEN gb = '�Ƶ�����' THEN 1 END),0) mac
FROM fastfood
WHERE gb IN('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu)
ORDER BY city DESC);

����3]
�ܹ��� ���� SQL�� �ٸ����·� �����ϱ�
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






















