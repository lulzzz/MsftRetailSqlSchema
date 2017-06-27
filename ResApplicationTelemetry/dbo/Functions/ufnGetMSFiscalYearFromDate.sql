--MSRETEL-382 (06.23.2017): Add MS fiscal year calculations

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