-- 07.05.2017 (MSRETEL-393): refactoring to support Power BI consumption

CREATE VIEW [vwOtherAzureResourceDailyCost] AS
SELECT 
    u.BillingDate,
    u.SubscriptionId,
    u.MeterCategory,
    u.MeterSubCategory,
    u.ResourceUri,
    SUM((u.Quantity)*(c.MeterRate0)) as 'Total'
FROM 
    AzureResourceUsage u, 
    AzureRateCard c
WHERE 
    u.MeterId = c.MeterId AND ((u.MeterSubCategory = 'Data Factory') OR (u.MeterCategory = 'Azure IoT Hub'))
group by u.BillingDate, u.SubscriptionId, u.MeterCategory, u.MeterSubCategory, u.ResourceUri