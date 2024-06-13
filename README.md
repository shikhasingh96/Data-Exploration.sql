The "Covid 19 Data Exploration" project involves analyzing COVID-19 data obtained from Our World in Data(https://ourworldindata.org/covid-deaths) spanning from 2020 to 2024. The project leverages SQL to explore and derive insights on COVID-19 cases, deaths, and vaccination rates across various regions worldwide.

- Here's a detailed description of the project and its components:

## Project Overview
This project focuses on exploring and analyzing COVID-19 data using a range of SQL functionalities. The main goals include:

1. Extracting and transforming data.

2. Performing calculations and aggregations.

3. Using advanced SQL techniques such as Common Table Expressions (CTEs), temporary tables, window functions, and views.

4. Deriving insights on COVID-19 cases, deaths, vaccinations, and their impacts across different regions and populations.

## Key SQL Techniques Used

- Joins: Combining data from different tables to perform comprehensive analysis.

- CTEs (Common Table Expressions): Simplifying complex queries and enhancing readability.

- Temporary Tables: Storing intermediate results for further manipulation.

- Window Functions: Performing calculations across a set of table rows related to the current row.

- Aggregate Functions: Summarizing data, such as sums and averages.

- Views: Creating virtual tables to store query results for future use.

- Data Type Conversions: Ensuring proper data formats for calculations and comparisons.

## Detailed Steps and Queries

1. Schema Information : Retrieve column names and data types from the CovidDeaths table.
Describe the structure of the CovidDeaths table.

2. Data Extraction and Formatting :
Select and order data from the CovidDeaths table where the continent is not null.
Format the date column to yyyy-MM-dd.

3. Selecting Key Columns for Analysis :
Extract essential columns like location, date, total cases, new cases, total deaths, and population.

4. Analysis of Total Cases vs. Total Deaths :
Calculate and display the likelihood of dying if infected by COVID-19.
Show data for locations containing the keyword 'STATE'.

5. Analysis of Total Cases vs. Population :
Determine the percentage of the population infected by COVID-19.

6. Highest Infection Rates :
Identify countries with the highest infection rates compared to their population.
Identify countries with the highest death count per population.

7. Continental Analysis :
Show continents with the highest death count per population.
Aggregate global numbers for total cases, total deaths, and death percentage.

8. Vaccination Data Integration :
Combine COVID-19 death data with vaccination data to show the percentage of the population vaccinated.
Use window functions to calculate rolling sums of vaccinations.

9. CTE and Temporary Table Usage :
Create a CTE to perform calculations and analyze vaccination data.
Create a temporary table to store and analyze vaccination data.

10. Creating Views for Visualization :
Create a view to store calculated data for future visualizations.


## Conclusion

The project provides a thorough exploration of COVID-19 data using advanced SQL techniques. It demonstrates how to derive meaningful insights from raw data, such as infection and death rates, vaccination progress, and the impact on different regions. The use of advanced SQL techniques such as CTEs, temporary tables, and views enhances the efficiency and organization of the analysis, making the data exploration process more manageable and insightful.




















