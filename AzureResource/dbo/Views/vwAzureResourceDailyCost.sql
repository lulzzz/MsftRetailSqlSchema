-- 07.01.2017 (MSRETEL-391): add 'SubProject' tag to Azure portal to improve documention/reporting
-- 07.05.2017 (MSRETEL-393): refactoring to support Power BI consumption

CREATE VIEW [dbo].[vwAzureResourceDailyCost]
	AS

SELECT res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate, sum(cost.Total) as 'Cost'
FROM vwModernAzureResourceDailyCost cost, AzureResourceBase res
WHERE cost.ResourceUri = res.ResourceId
GROUP BY res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate

UNION

SELECT res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate, sum(cost.Total) as 'Cost'
FROM vwClassicAzureResourceDailyCost cost, AzureResourceBase res, ClassicAzureResourceMap map
WHERE res.ResourceId = map.ResourceUri AND cost.[Name] = map.InfoFieldProject
GROUP BY res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate

UNION 

SELECT res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate, sum(cost.Total) as 'Cost'
FROM vwOtherAzureResourceDailyCost cost, AzureResourceBase res, OtherAzureResourceMap map
WHERE res.ResourceId = map.ResourceUri AND cost.ResourceUri = map.UsageResourceUri
GROUP BY res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate