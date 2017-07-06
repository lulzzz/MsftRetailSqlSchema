-- 07.06.2017 (MSRETEL-393): get azure data factory (adf) parent resource id from child adf resource id

CREATE FUNCTION [dbo].[ufnGetAzureFactoryResourceUri](@AzureResourceUsageUri VARCHAR(500))
    RETURNS VARCHAR(500)
AS
BEGIN

DECLARE @StringFragment VARCHAR(200)
DECLARE @ResourceUri VARCHAR(500)
DECLARE @RowCount INT

SET @ResourceUri = '/'
SET @RowCount = 0

DECLARE AzureResourceUri_Cursor CURSOR FOR 
	select value 
from STRING_SPLIT (@AzureResourceUsageUri, '/' ) 
WHERE RTRIM(value) <> ''

OPEN AzureResourceUri_Cursor 

FETCH NEXT FROM AzureResourceUri_Cursor INTO
    @StringFragment

WHILE @@FETCH_STATUS = 0
BEGIN
    --print @StringFragment
	if (@RowCount < 8)
	BEGIN
	  IF (@RowCount = 7)
	    SET @ResourceUri = CONCAT(@ResourceUri,@StringFragment)
	  ELSE
	    SET @ResourceUri = CONCAT(@ResourceUri,@StringFragment,'/')
	  SET @RowCount = @RowCount + 1
	END
	FETCH NEXT FROM AzureResourceUri_Cursor INTO
	@StringFragment
END

--print @ResourceUri
--print @RowCount

CLOSE AzureResourceUri_Cursor 
DEALLOCATE AzureResourceUri_Cursor


	RETURN @ResourceUri;
END