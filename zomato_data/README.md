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

## Business Problem

The business needed a structured operations analysis framework to monitor delivery performance across multiple factors—such as geography, traffic density, and multi-order behavior—and identify key bottlenecks and improvement areas that directly impact customer experience, delivery efficiency, and operational scalability.

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

- Geographical Inefficiencies: Semi-Urban areas show the longest delivery times (~49 min) and lowest ratings (4.50), despite very short distances, indicating systemic performance gaps.

- Traffic Misallocation: High-traffic orders placed near restaurants still face delays due to delivery partners being dispatched from farther away — revealing assignment inefficiencies.

- Multi-Order Tradeoff: As riders handle more orders, delivery time increases proportionally, but customer ratings drop sharply once there are 2+ additional orders, despite shorter travel distance.

- Operational Sweet Spot: Handling exactly one extra order appears optimal — it keeps delivery time stable and minimizes rating impact, while avoiding the overload risks tied to 2+ orders.


