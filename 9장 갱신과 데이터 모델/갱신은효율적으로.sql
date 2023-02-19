-- NULL 채우기
UPDATE OmitTbl
SET val = (
    SELECT val
    FROM OmitTbl ot1
    WHERE ot1.keycol = OmitTbl.keycol
        AND ot1.seq = (
            SELECT MAX(seq)
            FROM OmitTbl ot2
            WHERE ot2.keycol = OmitTbl.keycol
                AND ot2.seq < OmitTbl.seq
                AND ot2.val IS NOT NULL
        )
)
WHERE val IS NULL;

-- 반대로 NULL을 작성
UPDATE OmitTbl
SET val = CASE WHEN val = (
    SELECT val
    FROM OmitTbl ot1
    WHERE o1.keycol = OmitTbl.keycol
        AND ot1.seq = (
            SELECT MAX(seq)
            FROM OmitTbl ot2
            WHERE ot2.keycol = OmitTbl.keycol
                AND ot2.seq < OmitTbl.seq
        )
) THEN NULL ELSE val END;