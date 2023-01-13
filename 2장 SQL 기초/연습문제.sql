-- Address 테이블에서 성별 별로 나이 순위(건너뛰기 있게)를 매기는 SELECT 구문

SELECT name, sex, age, RANK() OVER(PARTITION BY sex ORDER BY age)
FROM Address;