-- 4) Weather Impact Analysis

-- Q4.1) How do different weather conditions impact delivery times?
SELECT Weather_conditions, ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY Weather_conditions
ORDER BY avg_time DESC;
-- Weather conditions like Cloudy, Fog lead to higher average delivery times around 28 minutes
-- With Sunny conditions leading to lower average times around 21 minutes.

-- Q4.2) Which cities are most vulnerable to weather delays?
SELECT City, Weather_conditions, ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY City, Weather_conditions
ORDER BY avg_time DESC;
-- The Semi-Urban city shows the highest average delivery times during all weather conditions averaging around 50 minutes,
-- While Metropolitan and Urban cities have lower average times around 20-30 minutes.

-- Q4.3) Is rain traffic worse than peak-hour traffic?
SELECT CASE 
    WHEN Road_traffic_density = 'High' THEN 'Peak Hour Traffic'
    WHEN Weather_conditions = 'Stormy' THEN 'Rain Traffic'
    ELSE 'Other'
END AS traffic_type,
ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY traffic_type
ORDER BY avg_time DESC; 
-- No peak hour traffic has higher average delivery time around 27 minutes compared to rain traffic around 25 minutes.