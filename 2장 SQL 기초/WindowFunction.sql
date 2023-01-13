-- Group by와 비슷하지만 집약을 하지 않는다.

SELECT address, COUNT(*) OVER(PARTITION BY address)
FROM Address;

SELECT name, age, RANK() OVER(ORDER BY age DESC) AS rnk
FROM Address;