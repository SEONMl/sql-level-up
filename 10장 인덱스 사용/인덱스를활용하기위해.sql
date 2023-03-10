-- 1. 카디널리티와 선택률
-- 카디널리티: 값의 균형
-- 선택률: 특정 필드값을 지정했을 때 테이브 전체에서 몇 개의 레코드가 선택되는지
--  클러스터링 팩터 : 저장소에 같은 값이 어느 정도 물리적으로 뭉쳐 존재하는지를 나타내는 지표

-- 2. 인덱스를 사용하는 것이 좋은지 판단하려면
-- 카디널리티가 높을 것, 평균치에 많이 흩어져 있을수록 좋은 인덱스 후보
-- 선택률이 낮을 것, 한 번의 선택으로 레코드가 조금만 선택되는 것이 좋은 후보
-- 선택률이 10%보다 높다면 테이블 풀 스캔을 하는 게 더 빠를 가능성이 크다.