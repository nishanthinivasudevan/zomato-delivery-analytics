-- To run this script
-- mysql -u root -p zomato_data < "D:\repository\zomato_data\zomato_queries.sql"

-- General Ratings Distribution
SELECT CASE
WHEN Delivery_person_Ratings >= 5 THEN '5: Excellent'
WHEN Delivery_person_Ratings >= 4 AND Delivery_person_Ratings < 5 THEN '4: Good'
WHEN Delivery_person_Ratings >= 3 AND Delivery_person_Ratings < 4 THEN '3: Average'
WHEN Delivery_person_Ratings >= 2 AND Delivery_person_Ratings < 3 THEN '2: Bad'
ELSE '1: Poor' 
END AS rating_description,
COUNT(*) AS rating_distribution
FROM zomato
GROUP BY rating_description
ORDER BY rating_description DESC;

-- General Age Distribution
SELECT CASE
WHEN Delivery_person_Age > 50 THEN '50+'
WHEN Delivery_person_Age >= 40 AND Delivery_person_Age <= 50 THEN '40-50'
WHEN Delivery_person_Age >= 30 AND Delivery_person_Age < 40 THEN '30-40'
WHEN Delivery_person_Age >= 20 AND Delivery_person_Age < 30 THEN '20-30'
ELSE '10-20' 
END AS age_bracket,
COUNT(*) AS age_distribution
FROM zomato
GROUP BY age_bracket
ORDER BY age_bracket DESC;

-- Rating vs Age Analysis
SELECT CASE
WHEN Delivery_person_Ratings >= 5 THEN '5: Excellent'
WHEN Delivery_person_Ratings >= 4 AND Delivery_person_Ratings < 5 THEN '4: Good'
WHEN Delivery_person_Ratings >= 3 AND Delivery_person_Ratings < 4 THEN '3: Average'
WHEN Delivery_person_Ratings >= 2 AND Delivery_person_Ratings < 3 THEN '2: Bad'
ELSE '1: Poor' 
END AS rating_description,
CASE
WHEN Delivery_person_Age > 50 THEN '50+'
WHEN Delivery_person_Age >= 40 AND Delivery_person_Age <= 50 THEN '40-50'
WHEN Delivery_person_Age >= 30 AND Delivery_person_Age < 40 THEN '30-40'
WHEN Delivery_person_Age >= 20 AND Delivery_person_Age < 30 THEN '20-30'
ELSE '10-20' 
END AS age_bracket,
COUNT(*) AS rating_age_distribution
FROM zomato
GROUP BY rating_description, age_bracket
ORDER BY rating_description DESC;

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

