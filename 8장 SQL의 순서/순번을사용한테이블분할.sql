-- 고전적인 집합 지향적 방법
SELECT (n1.num + 1) AS gap_start,
        '~',
        (MIN(n2.num - 1)) AS gap_end
FROM Numbers n1 INNER JOIN Numbers n2
    ON n2.num > n1.num
GROUP BY n1.num
HAVING (n1.num + 1)<MIN(n2.num);
-- 스캔 1회, 결합 1회

-- 절차 지향적 방법 - '다음 레코드'와 비교
SELECT num+1 AS gap_start,
        '~',
        (num + diff-1) AS gap_end
FROM (SELECT num , MAX(num) 
                    OVER(ORDER BY num
                        ROWS BETWEEN 1 FOLLOWING
                            AND 1 FOLLOWING) - num
    FROM Numbers) TMP(num, diff)
WHERE diff <> 1; -- diff != 1
-- 스캔 1회, 정렬 1회, 결합 0회