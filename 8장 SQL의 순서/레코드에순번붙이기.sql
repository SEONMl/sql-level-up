-- 1. 기본 키가 한 개의 필드인 경우 (student_id)
-- 윈도우 함수 사용 (스캔 1회)
SELECT student_id,
    ROW_NUMBER() OVER(ORDER BY student_id) AS seq
FROM Weights;

-- 상관 서브쿼리 사용 (스캔 2회)
SELECT student_id,
    (SELECT COUNT(*)
    FROM Weights w2
    WHERE w2.student_id <= w1.student_id) AS seq
FROM Weights w1;

-- 2. 기본 키가 여러 개의 필드로 구성되는 경우 (class와 student_id)
-- 윈도우 함수 사용
SELECT class, student_id,
    ROW_NUMBER() OVER(ORDER BY class, student_id) AS seq
FROM Weights;

-- 상관 서브쿼리 사용
SELECT calss, student_id,
    (SELECT COUNT(*)
    FROM Weights w2
    WHERE (w2.class, w2.student_id) -- 다중 필드 비교
            <= (w1.class, w1.student_id)) AS seq
FROM Weights w1;

-- 3. 그룹마다 순번을 붙이는 경우
-- 윈도우 함수를 사용
SELECT class, student_id,
    ROW_NUMBER() OVER(PARTITION BY class 
                      ORDER BY student_id) AS seq
FROM Weights;

-- 상관 서브쿼리 사용
SELECT class, student_id,
    (SELECT COUNT(*)
    FROM Weights w2
    WHERE w2.class = w1.class
        AND w2.student_id <= w1.student_id) AS seq
FROM Weights w1;

-- 4. 순번과 갱신
-- 윈도우 함수 사용
UPDATE Weights
SET seq = 
    (SELECT seq
    FROM 
        (SELECT class, student_id,
            ROW_NUMBER() OVER(PARTITION BY class ORDER BY student_id) AS seq
        FROM Weights) seqTbl
    WHERE Weights.class = seqTbl.class
        AND Weights.student_id = seqTbl.student_id); -- ..?

-- 상관 서브쿼리 사용
UPDATE Weights
SET seq = 
    (SELECT COUNT(*)
    FROM Weights w2
    WHERE w2.class = Weights.class
        AND w2.student_id <= Weights.student_id);

