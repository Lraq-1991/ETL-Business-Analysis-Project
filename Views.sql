------- Views -----------------

USE BusinessDataset2022


BEGIN TRANSACTION;
GO


CREATE OR ALTER VIEW vCustomers
AS
WITH ListOfCustomers
AS(	-- List of unique CustomerID keys
	SELECT DISTINCT CustomerID
	FROM [dbo].[DimCustomerAgeData]
	UNION 
	SELECT DISTINCT CustomerID
	FROM DimCustomerMRRData
	UNION
	SELECT DISTINCT CustomerID
	FROM DimCustomerRevenueData
	UNION
	SELECT DISTINCT CustomerID
	FROM DimNewsletterInteractionData
	UNION
	SELECT DISTINCT CustomerID
	FROM DimRegionAndVerticalData
	UNION
	SELECT DISTINCT CustomerID
	FROM DimStatusAndLevelData
)
SELECT	-- Populate information from different dimension tables
	cte.CustomerID,
	age.CustomerAgeInMonths,
	mrr.MonthlyRecurringRevenue,
	rev.TotalRevenue,
	region.Region,
	region.Subvertical,
	region.Vertical,
	sl.CustomerLevel,
	sl.Status,
	inter.CompanyNewsletterInteractionCount
FROM ListOfCustomers cte
LEFT OUTER JOIN DimCustomerAgeData age
	ON cte.CustomerID = age.CustomerID
LEFT OUTER JOIN DimCustomerMRRData mrr
	ON cte.CustomerID = mrr.CustomerID
LEFT OUTER JOIN DimCustomerRevenueData rev
	ON cte.CustomerID = rev.CustomerID
LEFT OUTER JOIN DimRegionAndVerticalData region
	ON cte.CustomerID = region.CustomerID
LEFT OUTER JOIN DimStatusAndLevelData sl
	ON cte.CustomerID = sl.CustomerID
LEFT OUTER JOIN DimNewsletterInteractionData inter
	ON cte.CustomerID = inter.CustomerID;
GO



COMMIT TRANSACTION;





