SELECT company, year, sale,
    (SELECT company
    FROM Sales s2
    WHERE s1.company=s2.company
        AND year= ( SELECT MAX(year)
                    FROM Sales s3
                    WHERE s1.company=s3.company
                        AND s1.year>s3.year) 
        ) AS pre_company
FROM Sales s1;

-- 상관 서브쿼리는 테이블을 여러 번 스캔
-- 비등가 결헙으로 중첩 집합 생성