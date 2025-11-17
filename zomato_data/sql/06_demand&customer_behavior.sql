-- 6) Demand & Customer Behavior

-- Q6.1) Which order types are most popular in each city?
SELECT City, Type_of_order, COUNT(*) AS order_count
FROM zomato
GROUP BY City, Type_of_order
ORDER BY City, order_count DESC;
-- Metropolitian: Meal, Semi-Urban: Snack, Urban: Snack are the most popular order types in respective cities.

-- Q6.2) Are customers in certain cities more sensitive to wait times?
SELECT City, ROUND(AVG(Delivery_person_Ratings),1) AS avg_rating,
ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY City
ORDER BY avg_time DESC;
-- The rating is inversely proportional to average delivery time across cities.
-- Semi-Urban with highest avg time of 49 mins has lower rating of 4.5 
-- compared to Urban having avg time of 22 mins with higher rating of 4.7

-- Q6.3) Are festival days associated with unusually long delivery times?
SELECT Festival, ROUND(AVG(Time_taken_mins),2) AS avg_time
FROM zomato
GROUP BY Festival
ORDER BY avg_time DESC;
-- Yes, festival days have significantly higher average delivery times around 45 minutes 
-- compared to non festival days around 25 minutes.