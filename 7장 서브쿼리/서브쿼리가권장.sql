-- 결합과 집약 순서

-- 1. 결합을 먼저 수행
SELECT C.co_od, C.district, SUM(emp_nbr) AS sum_emp
FROM Companies C 
    INNER JOIN Shops S
    ON C.co_od = S.co_od
WHERE main_flg = 'Y'
GROUP BY C.co_od;
-- Aggregate -> Nested Loops

-- 2. 집약을 먼저 수행
SELECT C.co_od, C.district, sum_emp
FROM Companies C
    INNER JOIN (
        SELECT co_od, SUM(emp_nbr) AS sum_emp
        FROM Shops S
        WHERE main_flg = 'Y'
        GROUP BY co_od
    ) CSUM
    ON C.co_od = CSUM.co_od;
-- Nested Loops -> Aggregate

-- 사전에 결합 레코드 수를 압축해서 성능을 개선할 수 있음.