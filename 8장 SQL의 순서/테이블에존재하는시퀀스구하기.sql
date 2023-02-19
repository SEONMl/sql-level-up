-- 집합 지향적 방법
SELECT MIN(num) AS low,
        '~',
        MAX(num) AS high
FROM (SELECT n1.num, COUNT(n2.num) - n1.num
    FROM Numbers n1 INNER JOIN Numbers n2
        ON n2.num <= n1.num
    GROUP BY n1.num) N(num, gp)
GROUP BY gp;
-- 스캔 2회, 결합 1회, 집약 2회

-- 절차 지향적 방법
SELECT low, high
FROM (SELECT low,
        CASE WHEN high IS NULL 
            THEN MIN(high) OVER(ORDER BY seq 
                                ROWS BETWEEN CURRENT ROW
                                    AND UNBOUNDED FOLLOWING)
            ELSE high END AS high
    FROM (SELECT CASE WHEN COALESCE(prev_diff, 0) <> 1
                    THEN num ELSE NULL END AS low,
                CASE WHEN COALESCE(next_diff, 0) <> 1
                    THEN num ELSE NULL END AS high,
                seq
            FROM (SELECT num, 
                        MAX(num) 
                        OVER(ORDER BY num
                            ROWS BETWEEN 1 FOLLOWING 
                                    AND 1 FOLLOWING) - num AS next_diff,
                        num - MAX(num) 
                        OVER(ORDER BY num
                            ROWS BETWEEN 1 PRECEDING 
                                    AND 1 PRECEDING) AS prev_diff,
                        ROW_NUMBER() OVER (ORDER BY num) AS seq
                  FROM Numbers) TMP1 ) TMP2) TMP3
WHERE low IS NOT NULL;
-- ㅎ...