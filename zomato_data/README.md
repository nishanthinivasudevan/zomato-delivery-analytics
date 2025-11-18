# Zomato Delivery Efficiency Analytics
End-to-End Data Analytics Project — Python (ETL) + MySQL (Data Warehouse) + Power BI (Dashboard)

![Delivery Timing Trends](zomato_data/powerbi/delivery_timing_trends.png)

This project performs a complete analysis of Zomato’s delivery operations to understand delivery timing patterns, driver performance, geographical influences, and customer experience factors.

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

Average delivery time is reducing while average ratings are falling over time leading to play of other factors in decline of delivery ratings.
- Semi-urban areas suffer 30% slower deliveries.
- Weather (Cloudy/fog) increases average delivery time up to +2 mins.
- Electric scooters drive the shortest duration time with high positive environmental impact.
- Traffic jam conditions cause the highest delays.
- Delivery ratings peak for riders aged between 20-30 with an average of 4.7