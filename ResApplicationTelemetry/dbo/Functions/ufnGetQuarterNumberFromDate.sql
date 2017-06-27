--MSRETEL-382 (06.23.2017): Add MS fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetQuarterNumberFromDate](@DateToProcess DATETIME)
    RETURNS INT
AS
BEGIN

	DECLARE @QuarterNumber INT

	SET @QuarterNumber = (DATEPART(QUARTER, @DateToProcess))

	RETURN @QuarterNumber

END