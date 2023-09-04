-- Creating the database and setting it up for use
CREATE DATABASE mydatabase;
USE mydatabase;

-- Creating the fraud_oracle table with the relevant columns
CREATE TABLE fraud_oracle (
    Month VARCHAR(10),
    WeekOfMonth INT,
    DayOfWeek VARCHAR(20),
    Make VARCHAR(50),
    AccidentArea VARCHAR(20),
    DayOfWeekClaimed VARCHAR(20),
    MonthClaimed VARCHAR(10),
    WeekOfMonthClaimed INT,
    Sex VARCHAR(10),
    MaritalStatus VARCHAR(20),
    Age INT,
    Fault VARCHAR(20),
    PolicyType VARCHAR(50),
    VehicleCategory VARCHAR(20),
    VehiclePrice VARCHAR(20),
    FraudFound_P INT,
    PolicyNumber INT,
    RepNumber INT,
    Deductible INT,
    DriverRating INT,
    Days_Policy_Accident VARCHAR(20),
    Days_Policy_Claim VARCHAR(20),
    PastNumberOfClaims VARCHAR(20),
    AgeOfVehicle VARCHAR(20),
    AgeOfPolicyHolder VARCHAR(20),
    PoliceReportFiled VARCHAR(10),
    WitnessPresent VARCHAR(10),
    AgentType VARCHAR(20),
    NumberOfSuppliments VARCHAR(20),
    AddressChange_Claim VARCHAR(20),
    NumberOfCars VARCHAR(20),
    Year INT,
    BasePolicy VARCHAR(20)
);


-- Loading data into the fraud_oracle table from a CSV file
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/fraud_oracle.csv'
INTO TABLE fraud_oracle
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- No person of age 0 can drive a car, so removing such records.
DELETE FROM fraud_oracle WHERE Age = 0;

-- Analyzing the relationship between policyholder age, vehicle type, and fraudulent claims.
-- This query investigates if there's a notable connection between the age of the policyholder and the category 
-- of their vehicle when it comes to fraudulent claims. The results can provide insights into specific age 
-- and vehicle type combinations that might be more susceptible to fraud, aiding in targeted risk assessment.

SELECT 
    f.AgeOfPolicyHolder, 
    f.VehicleCategory, 
    COUNT(*) as TotalClaims,
    SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) as FraudClaims,
    (SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as PercentageFraudClaims
FROM 
    fraud_oracle f
GROUP BY 
    f.AgeOfPolicyHolder, f.VehicleCategory
HAVING
    FraudClaims > 0;


-- Analyzing the correlation between witness presence, accident location, and fraudulent claims.
-- This query offers insights into how the presence of a witness and the location of an accident (urban or rural)
-- might influence the likelihood of a claim being fraudulent. It helps to determine if either of these factors 
-- significantly impacts the fraud rate, which can be valuable for further investigations or policy adjustments.

SELECT 
    f.WitnessPresent, 
    f.AccidentArea, 
    COUNT(*) as TotalClaims,
    SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) as FraudClaims,
    (SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as PercentageFraudClaims
FROM 
    fraud_oracle f
GROUP BY 
    f.WitnessPresent, f.AccidentArea
HAVING
    FraudClaims > 0;


-- Investigating the monthly distribution of claims based on accident locations. 
-- This query provides insights into the frequency of claims and their fraudulent nature for each month, 
-- and whether the accident happened in an urban or rural setting. Such insights can help in understanding 
-- seasonal trends and the impact of location on claim frequency and fraudulence.

SELECT 
    f.Month, 
    f.AccidentArea, 
    COUNT(*) as TotalClaims,
    SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) as FraudClaims,
    (SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as PercentageFraudClaims
FROM 
    fraud_oracle f
GROUP BY 
    f.Month, f.AccidentArea
ORDER BY 
    f.Month, f.AccidentArea;


-- Analyzing the correlation between the number of cars involved in a claim and the filing of a police report 
-- with the occurrence of fraudulent claims. This query aims to identify patterns or trends related to the 
-- number of cars and the presence (or absence) of police reports in fraudulent scenarios.

SELECT 
    f.numberofcars, 
    f.PoliceReportFiled, 
    COUNT(*) as TotalClaims,
    SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) as FraudClaims,
    (SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as PercentageFraudClaims
FROM 
    fraud_oracle f
GROUP BY 
    f.numberofcars, f.PoliceReportFiled
HAVING
    FraudClaims > 0;


-- This query provides insights into the correlation between driver rating, age of the vehicle, 
-- and the percentage of fraudulent claims. It helps identify if specific driver ratings or vehicle ages 
-- are more susceptible to fraudulent claims.

SELECT 
    f.DriverRating, 
    f.AgeOfVehicle, 
    COUNT(*) as TotalClaims,
    SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) as FraudClaims,
    (SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as PercentageFraudClaims
FROM 
    fraud_oracle f
GROUP BY 
    f.DriverRating, f.AgeOfVehicle
HAVING
    FraudClaims > 0;

-- Analyzing the association between the duration since the last accident (in days) and the deductible amount 
-- with the likelihood of a claim being fraudulent. This query aims to identify patterns or correlations 
-- between the time since the last accident and the deductible amount chosen by the policyholder. 
-- Discovering such patterns could help insurance companies refine their risk models and better anticipate 
-- potential fraudulent claims based on these two parameters.

SELECT 
    Days_Policy_Accident, 
    Deductible, 
    COUNT(*) as TotalClaims,
    SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) as FraudClaims,
    (SUM(CASE WHEN FraudFound_P = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) as PercentageFraudClaims
FROM 
    fraud_oracle
GROUP BY 
    Days_Policy_Accident, Deductible
HAVING
    FraudClaims > 0;

-- This query aims to analyze the relationship between the type of agent handling the claim and 
-- the past number of claims made by the policyholder. By comparing these factors against the presence of fraud,
-- we can potentially identify patterns or trends that suggest higher likelihoods of fraud based on the agent type 
-- or the claim history of the policyholder.

-- The first CTE 'total_claims' counts the total number of claims for each combination of AgentType 
-- and PastNumberOfClaims.
WITH total_claims AS (
    SELECT 
        AgentType, 
        PastNumberOfClaims, 
        COUNT(*) as TotalClaims
    FROM 
        fraud_oracle
    GROUP BY 
        AgentType, PastNumberOfClaims
),

-- The second CTE 'fraud_claims' counts the number of fraudulent claims for each combination of AgentType 
-- and PastNumberOfClaims.
fraud_claims AS (
    SELECT 
        AgentType, 
        PastNumberOfClaims, 
        COUNT(*) as FraudClaims
    FROM 
        fraud_oracle
    WHERE 
        FraudFound_P = 1
    GROUP BY 
        AgentType, PastNumberOfClaims
)

-- The main SELECT statement then joins the two CTEs on AgentType and PastNumberOfClaims to 
-- calculate the percentage of fraudulent claims for each combination.
SELECT 
    total_claims.AgentType, 
    total_claims.PastNumberOfClaims, 
    TotalClaims, 
    FraudClaims, 
    (FraudClaims * 100.0 / TotalClaims) as PercentageFraudClaims
FROM 
    total_claims JOIN fraud_claims ON total_claims.AgentType = fraud_claims.AgentType 
                                         AND total_claims.PastNumberOfClaims = fraud_claims.PastNumberOfClaims;


-- This query is designed to analyze the correlation between the fault status of a claim (who was at fault) 
-- and the price category of the vehicle involved in the claim. By assessing these factors against the presence of fraud, 
-- we aim to identify if certain fault statuses or vehicle price categories are more susceptible to fraudulent claims.

-- The first CTE 'total_claims' calculates the total number of claims for each combination of Fault and VehiclePrice.
WITH total_claims AS (
    SELECT 
        Fault, 
        VehiclePrice, 
        COUNT(*) as TotalClaims
    FROM 
        fraud_oracle
    GROUP BY 
        Fault, VehiclePrice
),

-- The second CTE 'fraud_claims' counts the number of fraudulent claims for each combination of Fault and VehiclePrice.
fraud_claims AS (
    SELECT 
        Fault, 
        VehiclePrice, 
        COUNT(*) as FraudClaims
    FROM 
        fraud_oracle
    WHERE 
        FraudFound_P = 1
    GROUP BY 
        Fault, VehiclePrice
)

-- The main SELECT statement then joins the two CTEs on Fault and VehiclePrice to 
-- compute the percentage of fraudulent claims for each combination. The use of IFNULL ensures that 
-- if there are no fraudulent claims for a particular combination, the count and percentage will default to zero.
SELECT 
    total_claims.Fault, 
    total_claims.VehiclePrice, 
    TotalClaims,
    IFNULL(FraudClaims, 0) as FraudClaims,
    IFNULL((FraudClaims * 100.0 / TotalClaims), 0) as PercentageFraudClaims
FROM 
    total_claims LEFT JOIN fraud_claims ON total_claims.Fault = fraud_claims.Fault 
                                         AND total_claims.VehiclePrice = fraud_claims.VehiclePrice;


