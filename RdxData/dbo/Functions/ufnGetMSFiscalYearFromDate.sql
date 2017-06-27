-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetMSFiscalYearFromDate](@DateToProcess DATETIME)
    RETURNS int
AS
BEGIN

	DECLARE @MSFiscalYear INT, @WeekNumber INT

	SET @WeekNumber = (DATEPART(WEEK,@DateToProcess))

	SELECT @MSFiscalYear = 
	CASE
        WHEN (@WeekNumber > 27) THEN YEAR(DATEADD(year,1,@DateToProcess))
		ELSE (YEAR(@DateToProcess))
    END

	RETURN @MSFiscalYear

END