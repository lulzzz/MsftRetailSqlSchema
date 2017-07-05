-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations
-- 07.05.2017 (MSRETEL-392): fix fy 2018 week 1 bug (fy 2018 wk 1 data tagged as fy 2017 wk 52)

CREATE FUNCTION [dbo].[ufnGetMSFiscalWeekNumberFromDate](@DateToProcess DATETIME)
    RETURNS int
AS
BEGIN

	DECLARE @MSFiscalWeekNumber INT, @WeekNumber INT

	SET @WeekNumber = (DATEPART(WEEK,@DateToProcess))

	SELECT @MSFiscalWeekNumber = 
	CASE
		WHEN ((@WeekNumber = 27)) THEN (1)
        WHEN ((@WeekNumber - 27) < 0) THEN (53 + @WeekNumber - 27)
		ELSE (@WeekNumber - 26)
    END

	RETURN @MSFiscalWeekNumber

END