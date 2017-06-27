-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetWeekNumberFromDate](@DateToProcess DATETIME)
    RETURNS INT
AS
BEGIN

	DECLARE @WeekNumber INT

	SET @WeekNumber = (DATEPART(WEEK,@DateToProcess))

	RETURN @WeekNumber

END