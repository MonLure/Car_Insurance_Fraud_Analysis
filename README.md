# Car_Insurance_Fraud_Analysis

Project Description
Using SQL and Tableau, this project analyzes and visualizes data from an insurance fraud dataset to detect patterns and trends associated with fraudulent claims. Through comprehensive SQL queries and dynamic Tableau visualizations, insights into various parameters like age, vehicle type, witness presence, etc., are extracted to aid insurance companies in refining their risk models and better anticipating potential fraudulent claims.

SQL Queries Overview
The project involves a series of SQL queries:

Database Setup: Creation of a dedicated database and the fraud_oracle table.
Data Ingestion: Data is loaded from a CSV file into the fraud_oracle table.
Data Cleaning: Removal of unrealistic data entries.
Insight Extractions: Multiple complex SQL queries to investigate correlations such as:
Policyholder age vs. Vehicle type
Witness presence vs. Accident location
Monthly claims distribution by accident location
Number of cars and police report filing
Driver rating and age of the vehicle
Duration since the last accident vs. deductible amount
Agent type and past claims
Fault status vs. vehicle price category
Recommendations
Based on the analysis, several recommendations are proposed:

Witness Importance: Simplify forms to capture witness details, especially in rural areas.
Promote Police Reports: Offer incentives for providing police reports during claims.
Training for External Agents: Provide regular training to help them better identify potential fraud.
Leverage Advanced Analytics: Use predictive analytics and AI tools for deeper insights.
Monthly Monitoring: Prioritize surveillance during high-risk months.
Third-Party Claims Scrutiny: Ensure claims for certain vehicle price ranges are scrutinized.
Agent Performance Evaluation: Set up regular evaluations and reward programs.
Vehicle and Driver Monitoring: Pay closer attention to claims involving certain vehicle ages, types, and driver ratings.
Visualizations
Tableau is utilized to convert the extracted insights into intuitive visualizations, which can be found in the respective Tableau workbook linked in the repository.

Note: To fully understand the depth of the analysis, please review the provided SQL queries and the detailed insights and recommendations sections.

How to Run
Set up MySQL and create the necessary database and tables.
Load the dataset into the fraud_oracle table.
Execute the provided SQL queries.
Use the extracted data to create visualizations in Tableau.
