-- 07.01.2017 (MSRETEL-391): add 'SubProject' tag to Azure portal to improve documention/reporting

CREATE VIEW [dbo].[vwAllAzureResourceCostLast30DaysLn]
	AS

SELECT res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate, sum(cost.Total) as 'Cost'
FROM vwModernAzureResourceCostLast30DaysLn cost, AzureResourceBase res
WHERE cost.ResourceUri = res.ResourceId
GROUP BY res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate

UNION

SELECT res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate, sum(cost.Total) as 'Cost'
FROM vwClassicAzureResourceCostLast30DaysLn cost, AzureResourceBase res, ClassicAzureResourceMap map
WHERE res.ResourceId = map.ResourceUri AND cost.[Name] = map.InfoFieldProject
GROUP BY res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate

UNION 

SELECT res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate, sum(cost.Total) as 'Cost'
FROM vwOtherAzureResourceCostLast30DaysLn cost, AzureResourceBase res, OtherAzureResourceMap map
WHERE res.ResourceId = map.ResourceUri AND cost.ResourceUri = map.UsageResourceUri
GROUP BY res.ResourceName, res.ResourceType, res.SubscriptionName, res.Project, res.SubProject, res.Environment, cost.BillingDate