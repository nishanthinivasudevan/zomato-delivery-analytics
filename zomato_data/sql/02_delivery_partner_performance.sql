-- 2) Delivery Partner Performance

-- Q2.1) Who are the top-performing riders?
SELECT Delivery_person_ID, ROUND(AVG(Delivery_person_Ratings),2) AS avg_ratings
FROM zomato
GROUP BY Delivery_person_ID
ORDER BY avg_ratings DESC
LIMIT 20;
-- Top-performing riders have average ratings close to 5 ranging from 4.7 to 4.8

-- Q2.2) Do higher-rated riders deliver faster?
SELECT ROUND(AVG(Time_taken_mins),2) AS highrated_timings
FROM(
SELECT Delivery_person_ID, ROUND(AVG(Delivery_person_Ratings),2) AS avg_ratings, Time_taken_mins
FROM zomato
GROUP BY Delivery_person_ID, Time_taken_mins
ORDER BY avg_ratings DESC
LIMIT 20
) a;
-- Yes, higher-rated riders tend to have faster delivery times averaging around 25.45 minutes 
-- while average delivery time across all riders is around 26.29 minutes.

-- Q2.3) Does age correlate with delivery time (experience proxy)?
SELECT CASE
WHEN Delivery_person_Age >= 10 AND Delivery_person_Age < 20 THEN '10-19'
WHEN Delivery_person_Age >= 20 AND Delivery_person_Age < 30 THEN '20-29'
WHEN Delivery_person_Age >= 30 AND Delivery_person_Age < 40 THEN '30-39'
WHEN Delivery_person_Age >= 40 AND Delivery_person_Age < 50 THEN '40-49'
ELSE '50+'
END AS age_bracket,
ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY age_bracket
ORDER BY age_bracket DESC;
-- Delivery time is the lowest for 20-29 age bracket at around 22.99 minutes,
-- With both younger and older brackets showing higher average delivery times around 26 - 29 minutes

-- Q2.4) Do riders assigned multiple orders take significantly longer?
SELECT multiple_deliveries, ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY multiple_deliveries
ORDER BY multiple_deliveries DESC;
-- Yes, riders with multiple deliveries take longer averaging around 47 minutes for 3, 40 for 2 and 26 for 1 delivery.

-- Q2.5) Does rider vehicle condition influence delivery speed?
SELECT Vehicle_condition, ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY Vehicle_condition
ORDER BY Vehicle_condition DESC;
-- Yes, vehicle condition impacts delivery speed negatively with 3 to 1 having decreasing avg time but in small difference.
-- However, 0 has the highest average time which may indicate other factors at play.