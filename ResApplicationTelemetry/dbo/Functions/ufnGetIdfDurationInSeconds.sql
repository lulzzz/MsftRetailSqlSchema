--MSRETEL-298 (02.16.2017): Convert duration strings to integers (seconds)

CREATE FUNCTION [dbo].[ufnGetIdfDurationInSeconds](@duration VARCHAR(100))
    RETURNS int
AS
BEGIN

	DECLARE @hrs_int INT, @mins_int INT, @secs_int INT
	DECLARE @total_time_secs INT

	DECLARE @TimeIntervalValues TABLE
	(
	  IntervalValue VARCHAR(100)
	)

	INSERT INTO @TimeIntervalValues SELECT LTRIM(value) FROM STRING_SPLIT(@duration, ',')

	SET @hrs_int = (SELECT (REPLACE(IntervalValue,'hrs','')) from @TimeIntervalValues WHERE IntervalValue like  '%hrs%')
	SET @mins_int = (SELECT (REPLACE(IntervalValue,'mins','')) from @TimeIntervalValues WHERE IntervalValue like  '%mins%')
	SET @secs_int = (SELECT (REPLACE(IntervalValue,'secs','')) from @TimeIntervalValues WHERE IntervalValue like  '%secs%')

	SET @total_time_secs = ((60*60)*@hrs_int) + (@mins_int * 60) + @secs_int

	RETURN @total_time_secs

END