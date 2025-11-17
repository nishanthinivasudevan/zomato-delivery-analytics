-- Time-of-Day & Day-of-Week Patterns

-- Q5.1) What time of day has the most delays?
SELECT CASE
WHEN HOUR(Time_Orderd) >= 0 AND HOUR(Time_Orderd) < 6 THEN 'Midnight-6AM'
WHEN HOUR(Time_Orderd) >= 6 AND HOUR(Time_Orderd) < 12 THEN '6AM-Noon'
WHEN HOUR(Time_Orderd) >= 12 AND HOUR(Time_Orderd) < 18 THEN 'Noon-6PM'
ELSE '6PM-Midnight' END AS time_of_day,
ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY time_of_day
ORDER BY avg_time DESC; 
-- Delivery time increases steadily throughout the day with highest delays during 6PM-Midnight averaging around 27 minutes.
-- Whereas, 6AM-Noon has the lowest average delivery time around 21 minutes (No deliveries between Midnight-6AM).

-- Q5.2) Which hours need more riders?
SELECT HOUR(Time_Orderd) AS order_hour, COUNT(*) AS no_of_orders
FROM zomato
GROUP BY order_hour
ORDER BY no_of_orders DESC;
-- The top 5 hours with most orders fall between the 17:00 to 22:00 range signaling higher dinner orders
-- Could be a result of fatigue building up in end of day leading to more orders placed.

-- Q5.3) Are weekends slower than weekdays?
SELECT CASE
WHEN DATE_FORMAT(Order_Date, '%W') IN ('Saturday','Sunday') THEN 'Weekend'
ELSE 'Weekday'
END AS day_of_week,
ROUND(AVG(Time_taken_mins),2) AS avg_time, 
COUNT(*) AS no_of_orders
FROM zomato
GROUP BY day_of_week
ORDER BY avg_time DESC; 
-- The average delivery time doesn't vary significantly between weekends and weekdays,
-- However, weekdays see a higher number of orders around 33000 compared to weekends around 12000.
-- Possible reasons: 1. More days in weekdays 2. Weekends have more people dining out reducing delivery orders.