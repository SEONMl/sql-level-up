-- CASE 식과 윈도우 함수의 적절한 사용으로 반복문을 나타낼 수 있다.
-- SIGN 함수: 매개변수가 음수면 -1, 양수면 1, 0이면 0을 반환
SELECT company, year, sale,
    CASE SIGN(sale - MAX(sale)
                        OVER(PARTITION BY company
                             ORDER BY year
                             ROWS BETWEEN 1 PRECENDING AND 1 PRECENDING
                            )
            )
    WHEN 0 THEN '='
    WHEN 1 THEN '+'
    WHEN -1 THEN '-'
    ELSE NULL END AS var
FROM Sales;

-- MAX(컬럼) OVER(PARTITION BY 컬럼): 그룹 내 최댓값
-- WHERE 구가 없으므로 풀스캔 진행

ROWS BETWEEN 1 PRECENDING AND 1PRECENDING
-- 현재 레코드에서 1개 이전붙터 1개 이전까지의 레코드 범위

-- 윈도우 함수로 '직전 회사명'과 '직전 매상' 검색
SELECT company, year, sale,
    MAX(company)
        OVER(PARTITION BY company
                ORDER BY year
                ROWS BETWEEN 1 PRECENDING AND 1 PRECENDING) AS pre_company,
    MAX(sale)
        OVER(PARTITION BY company
                ORDER BY year
                ROWS BETWEEN 1 PRECENDING AND 1 PRECENDING) AS pre_sale
FROM Sales;