-- 7) Operational Bottleneck Identification

-- Q7.1) What are the top reasons for delays? (traffic, rain, multiple orders, rider rating, vehicle condition)
SELECT CASE
WHEN Road_traffic_density IN ('High','Jam') THEN 'High Traffic'
WHEN Weather_conditions IN ('Rainy','Stormy','Sandstorms') THEN 'Bad Weather'
WHEN multiple_deliveries > 1 THEN 'Multiple Orders'
WHEN Delivery_person_Ratings < 3 THEN 'Low Rider Rating'
WHEN Vehicle_condition < 2 THEN 'Poor Vehicle Condition'
ELSE 'Other'
END AS delay_reason,
ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY delay_reason
ORDER BY avg_time DESC;
-- In order of highest average delivery times: Multiple Orders (39 mins), Low Rider Rating (33 mins),
-- High Traffic (30 mins), Poor Vehicle Condition (23 mins), Bad Weather (23 mins), and other factors (21 mins).

-- Q7.2) Are delays clustered around specific delivery partners?
SELECT Delivery_person_ID, ROUND(AVG(Time_taken_mins),2) AS avg_time, COUNT(*) AS no_of_orders, 
ROUND(AVG(Delivery_person_Ratings),1) AS avg_rating
FROM zomato
GROUP BY Delivery_person_ID
HAVING avg_time>30
ORDER BY avg_time DESC;
-- 46 riders have average delivery times above 30 minutes. Interestingly, many of these riders have average ratings above 4.5
-- Which clashes with earlier observation of low rated riders causing delays. Indicates other factors at play.

-- Q7.3) Are restaurant preparation times causing hidden delays?
SELECT City, ROUND(AVG(TIMESTAMPDIFF(MINUTE, Time_Orderd, Time_Order_picked)),2) AS prep_time
FROM zomato
GROUP BY City
ORDER BY prep_time DESC;
-- All locations have similar average preparation times around 9-10 minutes.
WITH per_cte AS (
    SELECT 
        TIMESTAMPDIFF(MINUTE, Time_Orderd, Time_Order_picked) AS prep_time,
        NTILE(100) OVER (ORDER BY TIMESTAMPDIFF(MINUTE, Time_Orderd, Time_Order_picked)) AS percentile
    FROM zomato
)
SELECT
    MAX(CASE WHEN percentile = 50 THEN prep_time END) AS p50_median,
    MAX(CASE WHEN percentile = 90 THEN prep_time END) AS p90,
    MAX(CASE WHEN percentile = 95 THEN prep_time END) AS p95
FROM per_cte;
-- The median preparation time is around 9 minutes, with p90 and p95 being around 15 minutes respectively.
-- Indicating that restaurant prep times are generally not a major contributor to overall delivery delays.