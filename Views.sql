------- Views -----------------

USE BusinessDataset2022


BEGIN TRANSACTION;
GO

-- 1. Denormalizing tables into an Customer details view

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
	UNION
	SELECT DISTINCT CustomerID
	FROM DimHelpTicketData
	UNION
	SELECT DISTINCT CustomerID
	FROM DimProductBugTaskData
)
SELECT	-- Populate information from different dimension tables, -1 value means that no information was recorded for that column row
	cte.CustomerID,
	age.CustomerAgeInMonths,
	ISNULL(mrr.MonthlyRecurringRevenue, -1) MonthlyRecurringRevenue,
	ISNULL(rev.TotalRevenue, -1) TotalRevenue,
	ISNULL(region.Region, 'No information provided') Region,
	ISNULL(region.Subvertical, 'No information provided') Subvertical,
	ISNULL(region.Vertical, 'No information provided') Vertical,
	ISNULL(sl.CustomerLevel, 'No information provided') CustomerLevel,
	ISNULL(sl.Status, 'No information provided') Status,
	ISNULL(inter.CompanyNewsletterInteractionCount, -1) CompanyNewsletterInteractionCount,
	ISNULL(ticket.HelpTicketCount, -1) HelpTicketCount,
	ISNULL(ticket.HelpTicketLeadTimeHours, -1) HelpTicketLeadTimeHours,
	ISNULL(bug.ProductBugTaskCount, -1) ProductBugTaskCount
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
	ON cte.CustomerID = inter.CustomerID
LEFT OUTER JOIN DimHelpTicketData ticket
	ON cte.CustomerID = ticket.CustomerID
LEFT OUTER JOIN DimProductBugTaskData bug
	ON cte.CustomerID = bug.CustomerID
WHERE age.CustomerAgeInMonths IS NOT NULL
GO

-- Test View 
SELECT *
FROM vCustomers



COMMIT TRANSACTION;



