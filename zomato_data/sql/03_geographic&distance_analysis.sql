-- 3) Geographic & Distance Analysis

-- Q3.1) How does the distance between restaurant and customer affect delivery time?
SELECT CASE
WHEN Restaurant_distance < 50 THEN 'Very Near'
WHEN Restaurant_distance >= 50 AND Restaurant_distance < 100 THEN 'Near'
WHEN Restaurant_distance >= 100 AND Restaurant_distance < 150 THEN 'Far'
ELSE 'Very Far' END AS distance_description, 
ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY distance_description
ORDER BY avg_time DESC;
-- Contrary to expectations, 'Very Near' deliveries take the longest time on average, 'Very Far' taking second longest
-- And 'Near' taking the least time. This may indicate other factors influencing delivery time beyond just distance.