-- Data Cleansing

USE BusinessDataset2022;

BEGIN TRANSACTION;

--------------------------- 1. Verify Data types and Column names --------------------------------------------------


-- 1.1 CSATSurveyData


-- a. Display information for evaluation

SELECT *
FROM [dbo].[CSATSurveyData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CSATSurveyData';


-- b. Rename columns 

EXEC sp_rename 'dbo.CSATSurveyData.Customer ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.Year', 'SurveyYear', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.Quarter', 'SurveyQuarter', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.Survey Date', 'SurveyDate', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.Response Date', 'ResponseDate', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.How likely are you to recommend insider to a friend or colleague', 'RecommendationRate', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.How would you rate the value you gain from our company', 'CompanyRate', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.How frequently are you using our platform', 'UserFrequency', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.Please rate the overall quality of our products', 'QualityRate', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.Please rate the usability of the panel', 'PanelUsabilityRate', 'COLUMN';

EXEC sp_rename 'dbo.CSATSurveyData.Please rate your understanding of our reporting capabilities in', 'ReportCapabilityRate', 'COLUMN';


-- c. Convert columns data types 

ALTER TABLE [dbo].[CSATSurveyData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;	-- From NVARCHAR to VARCHAR, to increase performance

ALTER TABLE [dbo].[CSATSurveyData]
	ALTER COLUMN SurveyYear INT NOT NULL;	-- From FLOAT to INT

ALTER TABLE [dbo].[CSATSurveyData]
	ALTER COLUMN SurveyQuarter INT NOT NULL;	-- From FLOAT to INT

ALTER TABLE [dbo].[CSATSurveyData]
	ALTER COLUMN SurveyDate DATE NOT NULL;	-- From NVARCHAR to DATE

ALTER TABLE [dbo].[CSATSurveyData]
	ALTER COLUMN ResponseDate DATE NOT NULL;	-- From NVARCHAR to DATE

ALTER TABLE [dbo].[CSATSurveyData]
	ALTER COLUMN UserFrequency VARCHAR(20) NULL;	-- From NVARCHAR to VARCHAR, to increase performance

ALTER TABLE [dbo].[CSATSurveyData]
	ALTER COLUMN ReportCapabilityRate VARCHAR(100) NULL;	-- From NVARCHAR to VARCHAR, to increase performance


-- d. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[CSATSurveyData]
WHERE CustomerID iS NULL;


-- e. Check for non-unique CustomerID values

SELECT 
	CustomerID,
	COUNT(*)
FROM [dbo].[CSATSurveyData]
GROUP BY CustomerID;


-- 1.2 CustomerAgeData


-- a. Display information

SELECT *
FROM [dbo].[CustomerAgeData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CustomerAgeData';

-- b. Rename Columns

EXEC sp_rename 'dbo.CustomerAgeData.CRM ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.CustomerAgeData.Customer Age (Months)', 'CustomerAgeInMonths', 'COLUMN';


-- c. Convert columns data types 

ALTER TABLE [dbo].[CustomerAgeData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;	

-- d. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[CustomerAgeData]
WHERE CustomerID iS NULL;

-- 1.3 CustomerMRRData

-- a. Display Information

SELECT *
FROM [dbo].[CustomerMRRData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CustomerMRRData';


-- b. Rename Columns

EXEC sp_rename 'dbo.CustomerMRRData.Customer ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.CustomerMRRData.MRR', 'MonthlyRecurringRevenue', 'COLUMN';


-- c. Remove string characters from MonthlyRecurringRevenue column

UPDATE [dbo].[CustomerMRRData]
SET MonthlyRecurringRevenue = STUFF(MonthlyRecurringRevenue,1,1,'');

UPDATE [dbo].[CustomerMRRData]
SET MonthlyRecurringRevenue = REPLACE(MonthlyRecurringRevenue,',','');


-- d. Convert columns data types 

ALTER TABLE [dbo].[CustomerMRRData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;

ALTER TABLE [dbo].[CustomerMRRData]
	ALTER COLUMN MonthlyRecurringRevenue FLOAT NOT NULL;

-- e. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[CustomerMRRData]
WHERE CustomerID iS NULL;


-- 1.4 CustomerRevenueData

-- a. Display Information

SELECT *
FROM [dbo].[CustomerRevenueData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CustomerRevenueData';

-- b. Rename columns

EXEC sp_rename 'dbo.CustomerRevenueData.Customer ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.CustomerRevenueData.Total Revenue', 'TotalRevenue', 'COLUMN';

-- c. Remove string characters from TotalRevenue column

UPDATE [dbo].[CustomerRevenueData]
SET TotalRevenue = STUFF(TotalRevenue,1,1,'');

UPDATE [dbo].[CustomerRevenueData]
SET TotalRevenue = REPLACE(TotalRevenue, ',', '');

-- d. Change columns data types

ALTER TABLE [dbo].[CustomerRevenueData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;

ALTER TABLE [dbo].[CustomerRevenueData]
	ALTER COLUMN TotalRevenue FLOAT NULL;

-- e. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[CustomerRevenueData]
WHERE CustomerID iS NULL;


-- 1.5 HelpTicketData


-- a. Display Information

SELECT *
FROM [dbo].[HelpTicketData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'HelpTicketData';


-- b. Change columns names

EXEC sp_rename 'dbo.HelpTicketData.Customer ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.HelpTicketData.Help Ticket Count', 'HelpTicketCount', 'COLUMN';

EXEC sp_rename 'dbo.HelpTicketData.Help Ticket Lead Time (hours)', 'HelpTicketLeadTimeHours', 'COLUMN';


-- c. Change columns data types 

ALTER TABLE [dbo].[HelpTicketData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;


-- d. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[HelpTicketData]
WHERE CustomerID iS NULL;



-- 1.6 NewsletterInteractionData


-- a. Display Information

SELECT *
FROM [dbo].[NewsletterInteractionData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'NewsletterInteractionData';


-- b. Rename columns 

EXEC sp_rename 'dbo.NewsletterInteractionData.Customer ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.NewsletterInteractionData.Company Newsletter Interaction Count', 'CompanyNewsletterInteractionCount', 'COLUMN';


-- c. Change data types

ALTER TABLE [dbo].[NewsletterInteractionData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;


-- d. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[NewsletterInteractionData]
WHERE CustomerID iS NULL;



-- 1.7 ProductBugTaskData


-- a. Display Information

SELECT *
FROM [dbo].[ProductBugTaskData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ProductBugTaskData';

-- b. Rename Columns 

EXEC sp_rename 'dbo.ProductBugTaskData.Customer ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.ProductBugTaskData.Product Bug Task Count', 'ProductBugTaskCount', 'COLUMN';


-- c. Chage data types

ALTER TABLE [dbo].[ProductBugTaskData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;

-- d. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[ProductBugTaskData]
WHERE CustomerID iS NULL;


-- 1.8 RegionAndVerticalData


-- a. Display Information

SELECT *
FROM [dbo].[RegionAndVerticalData];

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'RegionAndVerticalData';


-- b. Rename columns 

EXEC sp_rename 'dbo.RegionAndVerticalData.Customer ID', 'CustomerID', 'COLUMN';


-- c. Remove rows with CustomerID null values

DELETE FROM [dbo].[RegionAndVerticalData]
WHERE CustomerID IS NULL;

DELETE FROM [dbo].[RegionAndVerticalData]
WHERE Region IS NULL;

-- d. Change data types

ALTER TABLE [dbo].[RegionAndVerticalData]
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;


ALTER TABLE [dbo].[RegionAndVerticalData]
	ALTER COLUMN Region VARCHAR(25) NOT NULL;

ALTER TABLE [dbo].[RegionAndVerticalData]
	ALTER COLUMN Vertical VARCHAR(50) NULL;

ALTER TABLE [dbo].[RegionAndVerticalData]
	ALTER COLUMN Subvertical VARCHAR(50) NULL;


-- e. Check for NULL values 

SELECT 
	COUNT(*) -- 0 values
FROM [dbo].[RegionAndVerticalData]
WHERE CustomerID iS NULL;


-- 1.9 StatusAndLevelData


-- a.  Display Information

SELECT *
FROM dbo.StatusAndLevelData;

SELECT
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'StatusAndLevelData';

-- b. Check for NULL values 

SELECT COUNT(*) -- 4 values
FROM dbo.StatusAndLevelData
WHERE [Customer ID] IS NULL


-- c. Rename Columns 

EXEC sp_rename 'dbo.StatusAndLevelData.Customer ID', 'CustomerID', 'COLUMN';

EXEC sp_rename 'dbo.StatusAndLevelData.Customer Level', 'CustomerLevel', 'COLUMN';

-- d. Remove columns 

DELETE FROM dbo.StatusAndLevelData
WHERE CustomerID IS NULL;

-- e. Change Data types

ALTER TABLE dbo.StatusAndLevelData
	ALTER COLUMN CustomerID VARCHAR(15) NOT NULL;

ALTER TABLE dbo.StatusAndLevelData
	ALTER COLUMN Status VARCHAR(25) NULL;

ALTER TABLE dbo.StatusAndLevelData
	ALTER COLUMN CustomerLevel VARCHAR(25) NULL;




-------------------------------- 2. Define Primary keys ----------------------------------------------------



-- a. Verify existing indexes

EXEC sp_pkeys CSATSurveyData;

EXEC sp_pkeys CustomerAgeData;

EXEC sp_pkeys CustomerMRRData;

EXEC sp_pkeys CustomerRevenueData;

EXEC sp_pkeys HelpTicketData;

EXEC sp_pkeys ProductBugTaskData;

EXEC sp_pkeys RegionAndVerticalData;

EXEC sp_pkeys StatusAndLevelData;

EXEC sp_pkeys NewsletterInteractionData;


-- Results: No primary keys found


-- b. Create Primary keys


-- Creating SurveyID and set as primary key for CSATSurveyData

ALTER TABLE CSATSurveyData
	ADD SurveyID INT IDENTITY(1,1) NOT NULL;

ALTER TABLE CSATSurveyData
	ADD CONSTRAINT PK_CSATSurveyData_SurveyID PRIMARY KEY CLUSTERED (SurveyID);


-- Set primary key for CustomerAgeData

ALTER TABLE CustomerAgeData
	ADD CONSTRAINT PK_CustomerAgeData_CustomerID PRIMARY KEY CLUSTERED (CustomerID);


-- Set primary key for CustomerMRRData

ALTER TABLE CustomerMRRData
	ADD CONSTRAINT PK_CustomerMRRData_CustomerID PRIMARY KEY CLUSTERED (CustomerID);


-- Set primary key for CustomerRevenueData

ALTER TABLE CustomerRevenueData
	ADD CONSTRAINT PK_CustomerRevenueData_CustomerID PRIMARY KEY CLUSTERED (CustomerID);


-- Set primary key for HelpTicketData

ALTER TABLE HelpTicketData
	ADD TicketID INT IDENTITY(1,1) NOT NULL;

ALTER TABLE HelpTicketData
	ADD CONSTRAINT PK_HelpTicketData_TicketID PRIMARY KEY CLUSTERED (TicketID);


-- Set primary key for ProductBugTaskData

ALTER TABLE ProductBugTaskData
	ADD BugID INT IDENTITY(1,1) NOT NULL;

ALTER TABLE ProductBugTaskData
	ADD CONSTRAINT PK_ProductBugTaskData_BugID PRIMARY KEY CLUSTERED (BugID);


-- Set primary key for RegionAndVerticalData

ALTER TABLE RegionAndVerticalData
	ADD CONSTRAINT PK_RegionAndVerticalData_CustomerID PRIMARY KEY CLUSTERED (CustomerID);


-- Set primary key for StatusAndLevelData

ALTER TABLE StatusAndLevelData
	ADD CONSTRAINT PK_StatusAndLevelData_CustomerID PRIMARY KEY CLUSTERED (CustomerID);


-- Set primary key for NewsletterInteractionData

ALTER TABLE NewsletterInteractionData
	ADD CONSTRAINT PK_NewsletterInteractionData_CustomerID PRIMARY KEY CLUSTERED (CustomerID);


------------------------------------ 3. Define foreign keys -------------------------------------

-- 3.1 Checking created PKs

SELECT *
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE

/*
	Based on the query result:

		The Fact tables are: CSATSurveyData, HelpTicketData, ProductBugTaskData

		The rest are dimension tables
*/


-- 3.2 Rename tables to differentiate between fact and dimension tables


EXEC sp_rename 'dbo.CSATSurveyData', 'FactCSATSurveyData';

EXEC sp_rename 'dbo.CustomerAgeData', 'DimCustomerAgeData';

EXEC sp_rename 'dbo.CustomerMRRData', 'DimCustomerMRRData';

EXEC sp_rename 'dbo.CustomerRevenueData', 'DimCustomerRevenueData';

EXEC sp_rename 'dbo.HelpTicketData', 'FactHelpTicketData';

EXEC sp_rename 'dbo.ProductBugTaskData', 'FactProductBugTaskData';

EXEC sp_rename 'dbo.RegionAndVerticalData', 'DimRegionAndVerticalData';

EXEC sp_rename 'dbo.StatusAndLevelData', 'DimStatusAndLevelData';

EXEC sp_rename 'dbo.NewsletterInteractionData', 'DimNewsletterInteractionData';


/*
	Based on how the tables are normalized and because tables were split in order to facilitate the trend analysis,
	create FK on the fact tables would require to point multiple dimension tables, therefore compromising the data integrity.
	Because of this no FK will be define for the current setup, instead will use CustomerID in each Fact table as an index
	to avoid full scans when searching specific values.

*/



-- 3.3 Creating clustered indexes


-- FactCSATSurveyData

CREATE NONCLUSTERED INDEX NCI_FactCSATSurveyData_CustomerID
	ON dbo.FactCSATSurveyData (CustomerID);


-- FactHelpTicketData

CREATE NONCLUSTERED INDEX NCI_FactHelpTicketData_CustomerID
	ON dbo.FactHelpTicketData (CustomerID);


-- FactProductBugTaskData

CREATE NONCLUSTERED INDEX NCI_FactProductBugTaskData_CustomerID
	ON dbo.FactProductBugTaskData (CustomerID);



-- Check created indexes 

SELECT name
FROM sys.indexes
WHERE type_desc = 'NONCLUSTERED'



----------------------------------------------------------------------

-- Aftermath Update: Converting NULLs into more appropriate values


SELECT *
FROM FactCSATSurveyData
WHERE PanelUsabilityRate IS NULL;

UPDATE FactCSATSurveyData
	SET UserFrequency = 0	-- 0 will represent "No feedback provided"
	WHERE PanelUsabilityRate IS NULL;


SELECT *
FROM FactCSATSurveyData
WHERE UserFrequency IS NULL;

UPDATE FactCSATSurveyData
	SET UserFrequency = 'No response'
	WHERE UserFrequency IS NULL;




SELECT *
FROM [dbo].[DimRegionAndVerticalData]
WHERE Vertical = 'Real Estate';

UPDATE DimRegionAndVerticalData
	SET Subvertical = 'Real Estate'
	WHERE Vertical = 'Real Estate'
	AND Subvertical IS NULL;


UPDATE DimRegionAndVerticalData
	SET 
		Subvertical = 'No information provided',
		Vertical = 'No information provided'
	WHERE Subvertical IS NULL
	AND Vertical IS NULL;



SELECT *
FROM DimRegionAndVerticalData
WHERE Vertical = 'Retail'

DELETE FROM DimRegionAndVerticalData
	WHERE Vertical = 'Retail'
	AND Subvertical IS NULL;

DELETE FROM DimRegionAndVerticalData
	WHERE Subvertical IS NULL
	AND Vertical IS NOT NULL;


UPDATE DimRegionAndVerticalData
	SET Vertical = 'Other'
	WHERE Vertical IS NULL;



SELECT *
FROM [dbo].[DimStatusAndLevelData]
WHERE CustomerLevel IS NULL

UPDATE DimStatusAndLevelData
	SET CustomerLevel = 'No categorized'
	WHERE CustomerLevel IS NULL;






COMMIT TRANSACTION;
