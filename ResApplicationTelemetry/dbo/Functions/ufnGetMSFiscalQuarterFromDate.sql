--MSRETEL-382 (06.23.2017): Add MS fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetMSFiscalQuarterFromDate](@DateToProcess DATETIME)
    RETURNS int
AS
BEGIN

	DECLARE @MSFiscalQuarter INT, @QuarterNumber INT

	SET @QuarterNumber = (DATEPART(QUARTER, @DateToProcess))

	SELECT @MSFiscalQuarter = 
	CASE
        WHEN (@QuarterNumber = 1) THEN 3
        WHEN (@QuarterNumber = 2) THEN 4
        WHEN (@QuarterNumber = 3) THEN 1
        WHEN (@QuarterNumber = 4) THEN 2
    END

	RETURN @MSFiscalQuarter

END