과제1]fastfood 테이블과 tax 테이블을 이용하여 다음과 같이 조회되도록 SQL작성
 1. 도시발전지수를 구하고
 2. 인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여
 3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 조인하여 아래와 같이 컬럼이 조회되도록 SQL 작성

순위 햄버거 시도, 햄버거 시군구, 햄버거 도시발전지수,국세청 시군구, 국세청 시군구, 국세청 연말정산 금액1인당 신고액

SELECT a.*, b.*
FROM
    (SELECT ROWNUM rank, a.sido, a.sigungu, a.city
     FROM
        (SELECT bk.sido, bk.sigungu, bk.cnt, mac.cnt, kfc.cnt, lot.cnt,
                ROUND((bk.cnt + mac.cnt + kfc.cnt)/ lot.cnt,2) city
         FROM
             (SELECT sido, sigungu, count(*) cnt
              FROM fastfood
              WHERE gb = '버거킹'
              GROUP BY sido, sigungu) bk, 
              (SELECT sido, sigungu, count(*) cnt
              FROM fastfood
              WHERE gb = '맥도날드'
              GROUP BY sido, sigungu) mac, 
              (SELECT sido, sigungu, count(*) cnt
              FROM fastfood
              WHERE gb = 'KFC'
              GROUP BY sido, sigungu) kfc, 
              (SELECT sido, sigungu, count(*) cnt
              FROM fastfood
              WHERE gb = '롯데리아'
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

과제2]
햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용 하였는데 (fastfood 테이블을 4번사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선(fastfood 테이블을 1번만 사용)
CASE, DECODE

SELECT ROWNUM rank, a.*
FROM
    (SELECT sido, sigungu, NVL(ROUND(sum(other)/sum(lot),2),0) city
     FROM
            (SELECT sido, sigungu, gb,
                case
                    WHEN gb IN('롯데리아') THEN NVL(count(*), 0)
                END lot,
                case
                    WHEN gb IN('버거킹', '맥도날드', 'KFC') THEN count(*)
                END other
             FROM fastfood 
             GROUP BY sido, sigungu, gb)
     GROUP BY sido, sigungu
     ORDER BY city DESC) a;

개별 햄버거점의 주소(파파이스, 맘스터치 제외하고 계산)
SELECT ROWNUM rank, sido, sigungu, city
FROM
(SELECT sido, sigungu, ROUND((kfc + mac + bk) /lot , 2) city
FROM
(SELECT sido, sigungu,
       NVL(SUM(CASE WHEN gb = '롯데리아' THEN 1 END),1) lot, NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END),0) kfc,
       NVL(SUM(CASE WHEN gb = '버거킹' THEN 1 END),0) bk, NVL(SUM(CASE WHEN gb = '맥도날드' THEN 1 END),0) mac
FROM fastfood
WHERE gb IN('버거킹', 'KFC', '맥도날드', '롯데리아')
GROUP BY sido, sigungu)
ORDER BY city DESC);

과제3]
햄버거 지수 SQL을 다른형태로 도전하기
SELECT ROWNUM rank, main.*
FROM ( SELECT sido, sigungu, ROUND(count(gb)/NVL((SELECT count(gb)
                                                  FROM fastfood f
                                                  WHERE gb IN ('롯데리아') 
                                                    AND fastfood.sido = f.sido
                                                    AND fastfood.sigungu = f.sigungu
                                                  GROUP BY sido, sigungu),1) ,2) dosidevelope
       FROM fastfood
       WHERE gb IN ('버거킹','맥도날드','KFC')
       GROUP BY sido, sigungu
       ORDER BY dosidevelope DESC ) main;






















