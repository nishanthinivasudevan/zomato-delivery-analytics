-- 1) Delivery Time Efficiency

-- Q1.1) Which cities have the fastest and slowest deliveries?
SELECT City, AVG(Time_taken_mins) AS average_delivery_time
FROM zomato
GROUP BY City
ORDER BY average_delivery_time ASC;
-- Urban Deliveries have the fastest deliveries on average, while Sem-Urban have the slowest with Metropolitan in between.

-- Q1.2) How does traffic density impact average delivery time?
SELECT Road_traffic_density, AVG(Time_taken_mins) AS average_delivery_time
FROM zomato
GROUP BY Road_traffic_density
ORDER BY average_delivery_time ASC;
-- The traffic density has a direct correlation with the average delivery time with 
-- Low, Medium, High, Jam has increasing delivery times respectively.

-- Q1.3) Which order types (meals, snacks, buffets) take longest to deliver?
SELECT Type_of_order, AVG(Time_taken_mins) AS average_delivery_time
FROM zomato
GROUP BY Type_of_order
ORDER BY average_delivery_time DESC;
-- No significant difference in delivery times across order types.

-- Q1.4) Are delivery times improving or worsening over time?
SELECT DATE_FORMAT(Order_Date,'%Y-%m') AS month, AVG(Time_taken_mins) AS average_delivery_time
FROM zomato
GROUP BY month
ORDER BY month;
-- Delivery times have been improving slightly over time.

-- Q1.5) What is the typical delivery time distribution (e.g., median, p90, p95)?
WITH per_cte AS (
    SELECT 
        Time_taken_mins,
        NTILE(100) OVER (ORDER BY Time_taken_mins) AS percentile
    FROM zomato
)
SELECT
    MAX(CASE WHEN percentile = 50 THEN Time_taken_mins END) AS p50_median,
    MAX(CASE WHEN percentile = 90 THEN Time_taken_mins END) AS p90,
    MAX(CASE WHEN percentile = 95 THEN Time_taken_mins END) AS p95
FROM per_cte;
-- The median delivery time is around 26 minutes, with p90 and p95 being around 40 and 44 minutes respectively.