-- 07.05.2017 (MSRETEL-393): creating for consumption by Power BI

CREATE VIEW [vwAzureSubscriptionDailyCost] AS
SELECT 
    u.BillingDate,
	u.SubscriptionId,
    SUM((u.Quantity)*(c.MeterRate0)) as 'Total'
FROM 
    AzureResourceUsage u, 
    AzureRateCard c
WHERE 
    u.MeterId = c.MeterId 
group by u.BillingDate, u.SubscriptionId