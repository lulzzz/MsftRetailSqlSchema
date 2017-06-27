-- MSRETEL-270 (01.13.2017): pull office build # from the office version number 
-- MSRETEL-309 (03.02.2017): add new office versions 1612 & 1701

/*

Official office version & build information pulled from here:
    https://technet.microsoft.com/en-us/library/mt592918.aspx

*/

CREATE FUNCTION [dbo].[ufnGetOfficeVersionFromBuildNumber] (@office_build VARCHAR(50))
RETURNS INT
WITH EXECUTE AS CALLER
AS
BEGIN

    DECLARE @office_version_number INT;
    DECLARE @office_build_number VARCHAR(50);

    -- Example build number: '16.0.7571.2072'
  
  IF (@office_build IS NOT NULL)
  BEGIN

	WITH OfficeBuild AS 
	(
		SELECT RowNum = row_number() OVER (ORDER BY (SELECT 0)), value as 'number'
		FROM STRING_SPLIT(@office_build, '.')  
		WHERE RTRIM(value) <> ''
	)

	SELECT @office_build_number = (SELECT TOP 1 number from OfficeBuild WHERE RowNum = 3)

	IF (@office_build_number = '7766')
	    SET @office_version_number = 1701
	ELSE IF (@office_build_number = '7668')
	    SET @office_version_number = 1612
	ELSE IF (@office_build_number = '7571')
	    SET @office_version_number = 1611
	ELSE IF (@office_build_number = '7466')
	    SET @office_version_number = 1610
	ELSE IF (@office_build_number = '7369')
	    SET @office_version_number = 1609
	ELSE IF (@office_build_number = '7341')
	    SET @office_version_number = 1608
	ELSE IF (@office_build_number = '7167')
	    SET @office_version_number = 1607
	ELSE IF (@office_build_number = '7070')
	    SET @office_version_number = 1606
	ELSE IF (@office_build_number = '6965')
	    SET @office_version_number = 1605
	ELSE IF (@office_build_number = '6868')
	    SET @office_version_number = 1604
	ELSE IF (@office_build_number = '6769')
	    SET @office_version_number = 1603
	ELSE IF (@office_build_number = '6741')
	    SET @office_version_number = 1602
	ELSE IF (@office_build_number = '6568')
	    SET @office_version_number = 1601
	ELSE IF (@office_build_number = '6366')
	    SET @office_version_number = 1511
	ELSE IF (@office_build_number = '6001')
	    SET @office_version_number = 1509
	ELSE
	    SET @office_version_number = NULL

  END

  RETURN @office_version_number;

END;