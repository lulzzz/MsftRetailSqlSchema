CREATE VIEW [vwClassicAzureResourceCostLast30DaysLn] AS
SELECT 
    u.BillingDate,
    u.SubscriptionId,
    u.MeterCategory,
    u.MeterSubCategory,
    u.[Name],
    SUM((u.Quantity)*(c.MeterRate0)) as 'Total'
FROM 
    AzureResourceUsage u, 
    AzureRateCard c
WHERE 
    u.MeterId = c.MeterId AND u.[Name] IS NOT NULL AND
	u.BillingDate <= (select CONVERT(date, DATEADD(day, -2, GETDATE()))) AND
	u.BillingDate >= (select CONVERT(date, DATEADD(day, -32, GETDATE())))
group by u.BillingDate, u.SubscriptionId, u.MeterCategory, u.MeterSubCategory, u.[Name]