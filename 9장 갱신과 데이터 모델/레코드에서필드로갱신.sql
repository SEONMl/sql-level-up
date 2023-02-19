UPDATE ScoreCols
SET (score_en, score_nl, score_mt)
    = (
        SELECT MAX(CASE WHEN subject='영어' 
                    THEN score
                    ELSE NULL END) AS score_en,
                MAX(CASE WHEN subject='국어' 
                    THEN score
                    ELSE NULL END) AS score_nl,
                 MAX(CASE WHEN subject='수학' 
                    THEN score
                    ELSE NULL END) AS score_mt
        FROM ScoreRows SR
        WHERE SR.student_id = ScoreCols.student_id
    );

-- UPDATE 구문의 중요한 기술
-- 다중 필드 할당, 스칼라 서브쿼리


-- NOT NULL 제약이 걸려있는 경우
UPDATE ScoreColsNN
SET (score_en, score_nl, score_mt)
    = (
        SELECT COALESCE(MAX(CASE WHEN subject='영어' 
                    THEN score
                    ELSE NULL END), 0) AS score_en,
                COALESCE(MAX(CASE WHEN subject='국어' 
                    THEN score
                    ELSE NULL END), 0) AS score_nl,
                COALESCE(MAX(CASE WHEN subject='수학' 
                    THEN score
                    ELSE NULL END), 0) AS score_mt
        FROM ScoreRows SR
        WHERE SR.student_id = ScoreCols.student_id
    )
WHERE EXISTS (
    SELECT *
    FROM ScoreRows
    WHERE student_id = ScoreColsNN.student_id
);
-- COALESCE(인자) : 인자 중 NULL이 아닌 첫 번째 값을 반환한다. 모두 NULL일 경우 NULL을 반환

-- MERGE 구문을 사용: UPDATE와 INSERT를 한 번에 시행하려고 고안된 기술
MERGE INTO ScoreColsNN
USING (
    SELECT student_id,
        COALESCE(MAX(CASE WHEN subject = "영어"
                        THEN score
                        ELSE NULL END), 0) AS score_en,
        COALESCE(MAX(CASE WHEN subject = "국어"
                        THEN score
                        ELSE NULL END), 0) AS score_nl,
        COALESCE(MAX(CASE WHEN subject = "수학"
                        THEN score
                        ELSE NULL END), 0) AS score_mt
    FROM ScoreRows
    GROUP BY student_id) SR
    ON (ScoreColsNN.student_id = SR.student_id)
WHEN MATCHED THEN
    UPDATE SET ScoreColsNN.score_en = SR.score_en,
            ScoreColsNN.score_nl = SR.score_nl,
            ScoreColsNN.score_mt = SR.score_mt;