-- 결합은 알고리즘이 복잡하므로 실행 계획 변동이 일어나기 쉬움.
-- 방지하기 위해 '결합을 사용하지 않는 것'이 중요한 전략

SELECT dept_id, dept_name
FROM Departments D
WHERE EXISTS (SELECT *
                FROM Employee E
                WHERE E.dept_id = D.dept_id); 
                -- 의 실행 계획은?
-- Semi Join 발생: EXISTS와 IN을 사용할 때 쓰이는 특수한 알고리즘
-- 일치하는 레코드를 발견한 시점에서 다음 레코드 검색을 생략, 일반적인 결합보다 성능이 좋다

SELECT dept_id, dept_name
FROM Departments D
WHERE NOT EXISTS (SELECT *
                FROM Employee E
                WHERE E.dept_id = D.dept_id);                
                -- 의 실행 계획은?
-- Anti Join 발생