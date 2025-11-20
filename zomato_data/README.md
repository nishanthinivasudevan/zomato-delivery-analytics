# Zomato Delivery Efficiency Analytics
End-to-End Data Analytics Project — Python (ETL) + MySQL (Data Warehouse) + Power BI (Dashboard)

![Delivery Timing Trends](/zomato_data/powerbi/dashboard_homepage.png)

This project performs a complete analysis of Zomato’s delivery operations to understand delivery timing patterns, driver performance, geographical influences, and customer experience factors. It features case studies drilling down into specific factors to improve customer satisfaction.

## Workflow:
Raw CSV → Python Cleaning & Transformation → MySQL Data Warehouse → Power BI Interactive Dashboard

## Executive Summary

Food delivery platforms face continuous challenges in ensuring fast, reliable, and cost-efficient deliveries.
Using Zomato's delivery dataset, this project uncovers insights on:
- Delivery time variability
- Driver ratings & performance
- Weather & road traffic impact
- Order type effects
- City-level differences
- Bottlenecks causing operational slowdowns

The result is a complete business-ready dashboard that allows stakeholders to drill down into all factors influencing delivery performance.

## Key Objectives

Build a clean data pipeline from raw CSV to structured, analytics-ready tables.

Analyze key factors affecting:
- Delivery timings
- Driver ratings
- Multiple deliveries effect
- Weather impact
- Festival impact

Develop a Power BI dashboard featuring:
- Trend analysis
- KPI cards
- Slicers for deep drill-downs
- Visual storytelling

Showcase Python, SQL, ETL, and BI skills end-to-end.

## Methodology

- Raw data ( [zomato_data](https://www.kaggle.com/datasets/saurabhbadole/zomato-delivery-operations-analytics-dataset/data) ) taken exported from kaggle
- Data cleaning including datatype fixing, imputing missing data, derived columns in python using pandas
- Dataset uploaded to MySQL server and queries to find insights from the data
- Power BI dashboard created using the SQL database for visual storytelling and dedicated deepdives to analyse the factors in detail

## Tech Stack

Python
- pandas
- numpy
- data cleaning
- custom functions
- datetime handling

SQL (MySQL)
- Window functions
- Aggregations
- Joins
- CTEs
- Performance queries

Power BI
- Interactive dashboard
- DAX for calculated measures
- Slicers, cards, tree maps, line charts, bar charts

## Key Business Insights 

Overall delivery time is improving, but customer ratings are declining, indicating deeper operational factors at play.
This project investigates three major drivers: Geography, Traffic Density, and Multiple Deliveries.

### Geographical Constraints: Semi-Urban Performance Gap
Semi-Urban regions consistently underperform across all delivery metrics.

Key Findings:
- Slowest delivery times: ~49 mins vs 26-min overall average
- Lowest customer ratings: 4.50 vs 4.63 overall
- Extremely low order volume: 0.3% of total orders
- Highest tendency for multiple deliveries, increasing delays
- Shortest distance (0.57 km), proving distance is not the cause of slow performance

Root Causes:
- Poor infrastructure slowing rider movement
- Low demand causing inconsistent or undertrained rider supply
- Limited brand presence and customer adoption

Recommendations:
- Strengthen quality control and rider training
- Increase brand awareness via local partnerships
- Limit multi-order assignments in Semi-Urban areas

### Traffic Density: Rider Assignment Inefficiency
Orders placed near restaurants still face high delivery times in traffic-heavy zones.

Insights:
- Riders are often dispatched from distant areas, delaying pickup
- High traffic amplifies these delays, even for short-distance orders

Recommendation:
- Improve the rider–order matching algorithm to prioritize nearest available delivery partners

### Multiple Orders: The Multi-Delivery Threshold
Handling more orders increases delivery time as expected, but deeper patterns emerge.

Key Findings:
- Direct increase in delivery time with each additional order
- Surprisingly, restaurant distance decreases when handling 2+ orders
- Ratings drop sharply despite shorter distances
- Volume of 2+ multi-deliveries is significantly low, indicating natural or system-avoided overload

Interpretation:
- Customers ordering locally for combined deliveries create high workload with low travel distance
- Even short distances can see delays when rider allocation is inefficient

Conclusion:
The optimal operational threshold is 1 extra order:
- Delivery time remains stable
- Ratings show minimal decline
- Rider workload stays manageable

Beyond this point, performance and customer satisfaction drop significantly.


