-- 크로스 결합, 외부 결합, 내부 결합: 기능적 관점으로 분류
-- 등가 결합, 비등가 결합: 결합 조건에 따라 분류

-- 자연 결합: 결합 조건을 따로 기술하지 않고 암묵적으로 같은 이름의 필드가 등호로 결합됨
SELECT *
FROM Employee NATURAL JOIN Departments;

-- 추천!
SELECT *
FROM Employee E INNER JOIN Departments D
    ON E.dept_id = D.dept_id;

SELECT *
FROM Employee E INNER JOIN Departments D
    USING (dept_id);