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
