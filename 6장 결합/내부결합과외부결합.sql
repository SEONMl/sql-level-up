-- 내부 결합: 양쪽 테이블 모두에 존재하는 필드를 결합 키로 사용하여 결합
SELECT *
FROM Employee E INNER JOIN Departments D
    ON E.dept_id = D.dept_id;

-- 외부 결합: 마스터 테이블 쪽에만 존재하는 키가 있을 때 해당 키를 제거하지 않고 결과에 보존한다.
SELECT *
FROM Employee E RIGHT OUTER JOIN Departments D
    ON E.dept_id = D.dept_id;