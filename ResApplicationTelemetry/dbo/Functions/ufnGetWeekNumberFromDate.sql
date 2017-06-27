--MSRETEL-382 (06.23.2017): Add MS fiscal year calculations

CREATE FUNCTION [dbo].[ufnGetWeekNumberFromDate](@DateToProcess DATETIME)
    RETURNS INT
AS
BEGIN

	DECLARE @WeekNumber INT

	SET @WeekNumber = (DATEPART(WEEK,@DateToProcess))

	RETURN @WeekNumber

END