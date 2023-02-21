-- 상관 서브쿼리 사용
INSERT INTO Stocks2
SELECT brand, sale_date, price,
    CASE SIGN(price - 
                (SELECT price
                FROM Stocks s1
                WHERE brand = Stocks.brand
                    AND sale_date = (
                        SELECT MAX(sale_date)
                        FROM Stocks s2
                        WHERE brand = Stocks.brand
                            AND sale_date < Stocks.sale_date )))
        WHEN -1 THEN '하락'
        WHEN 0 THEN '유지'
        WHEN 1 THEN '상승'
        ELSE NULL
    END
FROM Stocks;

-- 윈도우 함수 사용
INSERT INTO Stocks2
SELECT brand, sale_date, price,
    CASE SIGN(price - 
                    MAX(price) OVER(PARTITION BY brand
                                    ORDER BY sale_date
                                    ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING))
        WHEN -1 THEN '하락'
        WHEN 0 THEN '유지'
        WHEN 1 THEN '상승'
        ELSE NULL
    END
FROM Stocks;

-- INSERT SELECT: 성능적으로 고속 처리, 자기 참조를 허가하지 않는 데이터베이스에서도 사용 가능
--              / 같은 크기와 구조를 가진 데이터를 두 개 만들어야 함
