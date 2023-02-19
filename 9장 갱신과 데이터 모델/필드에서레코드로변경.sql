UPDATE ScoreRows
SET score = (
    SELECT CASE ScoreRows.subject
            WHEN '영어' THEN score_en
            WHEN '국어' THEN score_nl
            WHEN '수학' THEN score_mt
            ELSE NULL
        END
    FROM ScoreCols
    WHERE student_id = ScoreRows.student_id
);