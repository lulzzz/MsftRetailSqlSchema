-- 07.06.2017 (MSRETEL-393): map azure data factory (adf) parent resource id to child adf resource

/*
    DESCRIPTION - The PowerShell command 'Get-​Azure​Rm​Resource' is used to retrieve Azure resources. 
	However, for Azure Data Factory (ADF), only the parent level ADF name is retrieved. The child 
	resources (inputs, outputs, linked services, pipleines, etc) are not retrieved. Taking this 
	a step further, the PowerShell command 'Get-UsageAggregates' retrieves daily usage costs only
	for the child resources. The purpose of this stored procedure is to map the parent level resource
	id to the child level resource ids. For example:

	  PARENT: /subscriptions/38149edf-ec4c-40cf-88ef-315034440b1b/resourcegroups/msftretailcampaign/providers/Microsoft.DataFactory/datafactories/MsftCampaignDataFactory
      CHILD:  /subscriptions/38149edf-ec4c-40cf-88ef-315034440b1b/resourcegroups/msftretailcampaign/providers/Microsoft.DataFactory/datafactories/MsftCampaignDataFactory/datasets/ID-IdfAppUsage
*/

CREATE PROCEDURE [dbo].[uspMapAzureDataFactoryResources]
AS
BEGIN

DECLARE @AzureResourceUsageUri VARCHAR(500) = NULL
DECLARE @AzureResourceUri VARCHAR(500) = NULL
DECLARE @AzureResourceExists VARCHAR(500) = NULL


DECLARE AzureResourceUsageUri_Cursor CURSOR FOR 
	select ResourceUri from AzureResourceUsage 
	where CAST(UsageStartTime AS DATE) = CAST(DATEADD(DAY,-2,GETDATE()) AS DATE) and 
	MeterSubCategory = 'Data Factory'

OPEN AzureResourceUsageUri_Cursor 

FETCH NEXT FROM AzureResourceUsageUri_Cursor INTO
    @AzureResourceUsageUri

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @AzureResourceExists = (select top 1 UsageResourceUri from OtherAzureResourceMap where UsageResourceUri = @AzureResourceUsageUri)

	IF (@AzureResourceExists IS NULL)
	BEGIN
      SET @AzureResourceUri = [dbo].[ufnGetAzureFactoryResourceUri](@AzureResourceUsageUri)
	  IF ((@AzureResourceUsageUri IS NOT NULL) AND (@AzureResourceUsageUri IS NOT NULL))
	  BEGIN
	    INSERT INTO OtherAzureResourceMap(UsageResourceUri, ResourceUri) VALUES(@AzureResourceUsageUri, @AzureResourceUri)
	  END

	END

	FETCH NEXT FROM AzureResourceUsageUri_Cursor INTO
	@AzureResourceUsageUri
END


CLOSE AzureResourceUsageUri_Cursor 
DEALLOCATE AzureResourceUsageUri_Cursor

END