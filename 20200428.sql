--4
SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND (emp.sal > 2500
  AND emp.empno >7600)
  AND dept.dname = 'RESEARCH';

실습 join 1]; 과제
SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;


SELECT *
FROM BUYER;

SELECT *
FROM prod;

-- join2]
SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM prod JOIN buyer ON (prod.prod_buyer =  buyer.buyer_id);

SELECT count(*)
FROM prod JOIN buyer ON (prod.prod_buyer =  buyer.buyer_id);

SELECT count(*)
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;


--BUYER_NAME  별 건수 조회 쿼리 작성
SELECT buyer.buyer_name, count(*)
FROM prod JOIN buyer ON (prod.prod_buyer =  buyer.buyer_id)
GROUP BY buyer.buyer_name;

SELECT buyer.buyer_name, count(*)
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id
GROUP BY buyer.buyer_name;

--JOIN3

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM prod, member, cart
WHERE cart.cart_prod = prod.prod_id
  AND member.mem_id = cart.cart_member;

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM prod JOIN cart   ON (cart.cart_prod = prod.prod_id) 
          JOIN member ON (member.mem_id = cart.cart_member);

참고사항;
SELECT *
FROM
    (SELECT deptno, COUNT(*)
    FROM emp
    GROUP BY deptno)
WHERE deptno = 30;

SELECT deptno, COUNT(*)
FROM emp
WHERE deptno = 30
GROUP BY deptno;

cid : customer id
cnm : customer name
SELECT *
FROM customer;

pid : producy id
pnm : producy name 
SELECT *
FROM product;

cycle : 애음주기
cid : 고객 id
pid : 제품 id
day : 애음요일 (월요일 - 2, 화요일 ...)
cnt : 수량
SELECT *
FROM cycle;

--JOIN 4]

SELECT customer.cid, cnm, pid,day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
  AND customer.cnm IN ('brown', 'sally'); 
  
SELECT cid, cnm, pid,day, cnt
FROM customer NATURAL JOIN cycle
WHERE customer.cnm IN ('brown', 'sally'); 

--JOIN 5]
SELECT customer.cid, cnm, cycle.pid, pnm,day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
  AND customer.cnm IN ('brown', 'sally'); 

--JOIN 6]
SELECT customer.cid,cnm ,product.pid, pnm, sum(cycle.cnt) cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
GROUP BY customer.cid,cnm ,product.pid, pnm;

--JOIN 7]
SELECT product.pid, pnm, sum(cnt) cnt
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY product.pid, pnm;

--join 8 ~ 13 숙제]






