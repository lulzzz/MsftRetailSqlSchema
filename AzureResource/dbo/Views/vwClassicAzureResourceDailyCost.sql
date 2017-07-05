-- 07.05.2017 (MSRETEL-393): refactoring to support Power BI consumption

CREATE VIEW [vwClassicAzureResourceDailyCost] AS
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
    u.MeterId = c.MeterId AND u.[Name] IS NOT NULL
group by u.BillingDate, u.SubscriptionId, u.MeterCategory, u.MeterSubCategory, u.[Name]