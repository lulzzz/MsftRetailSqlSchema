-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetQuarterNumberFromDate](@DateToProcess DATETIME)
    RETURNS INT
AS
BEGIN

	DECLARE @QuarterNumber INT

	SET @QuarterNumber = (DATEPART(QUARTER, @DateToProcess))

	RETURN @QuarterNumber

END