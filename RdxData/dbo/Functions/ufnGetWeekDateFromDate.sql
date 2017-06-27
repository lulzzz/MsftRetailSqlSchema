-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetWeekDateFromDate](@DateToProcess DATETIME)
    RETURNS DATE
AS
BEGIN

	DECLARE @WeekDate DATE

	SET @WeekDate = (DATEADD(wk, DATEDIFF(wk,0,@DateToProcess), -1))

	RETURN @WeekDate

END