-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations
-- 07.05.2017 (MSRETEL-392): fix fy 2018 week 1 bug (fy 2018 wk 1 data tagged as fy 2017 wk 52)

CREATE FUNCTION [dbo].[ufnGetMSFiscalQuarterFromDate](@DateToProcess DATETIME)
    RETURNS int
AS
BEGIN

	DECLARE @MSFiscalQuarter INT, @WeekNumber INT

	SET @WeekNumber = (DATEPART(WEEK,@DateToProcess))

	SELECT @MSFiscalQuarter = 
	CASE
        WHEN ((@WeekNumber >= 1) AND (@WeekNumber <= 13)) THEN 3
		WHEN ((@WeekNumber >= 14) AND (@WeekNumber <= 26)) THEN 4
		WHEN ((@WeekNumber >= 27) AND (@WeekNumber <= 39)) THEN 1
		WHEN ((@WeekNumber >= 40) AND (@WeekNumber <= 53)) THEN 2
    END

	RETURN @MSFiscalQuarter

END