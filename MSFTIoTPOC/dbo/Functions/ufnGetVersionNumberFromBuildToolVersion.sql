-- MSRETEL-098 (09.22.2016): parses a build tool version string (e.g., "2.1_08012016") to a version number in decimal format (e.g., 2.100)

CREATE FUNCTION [dbo].[ufnGetVersionNumberFromBuildToolVersion](@minor_version_string VARCHAR(50))
    RETURNS DECIMAL(10,3)
AS
BEGIN
	--DECLARE @minor_version_string VARCHAR(50) = NULL;
	DECLARE @minor_version_decimal DECIMAL(10,3) = NULL;

	-- 09.22.2016 - This function deploys and executes without issue - Visual Studio 2015 Update 3/SSDT bug can be safely ignored  
	--Function: [dbo].[ufnGetVersionNumberFromBuildToolVersion] has an unresolved reference to object [STRING_SPLIT].[value].
	SET @minor_version_string = (select top 1 value from STRING_SPLIT(@minor_version_string, '_'))

	IF ((@minor_version_string IS NOT NULL) AND (ISNUMERIC(@minor_version_string) = 1))
		SET @minor_version_decimal = (SELECT CAST(@minor_version_string AS DECIMAL(10, 3)))

	RETURN @minor_version_decimal;
END