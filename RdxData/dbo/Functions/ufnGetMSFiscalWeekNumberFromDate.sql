-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetMSFiscalWeekNumberFromDate](@DateToProcess DATETIME)
    RETURNS int
AS
BEGIN

	DECLARE @MSFiscalWeekNumber INT, @WeekNumber INT

	SET @WeekNumber = (DATEPART(WEEK,@DateToProcess))

	SELECT @MSFiscalWeekNumber = 
	CASE
        WHEN ((@WeekNumber - 27) < 1) THEN (53 + @WeekNumber - 27)
		ELSE (@WeekNumber - 27)
    END

	RETURN @MSFiscalWeekNumber

END