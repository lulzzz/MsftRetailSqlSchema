CREATE FUNCTION dbo.ufnGetRandomHealthStatusName ()
RETURNS VARCHAR(50)
WITH EXECUTE AS CALLER
AS
BEGIN

	DECLARE @RandVal INT
	DECLARE @HealthStatusName VARCHAR(50)

	SET @RandVal = (SELECT RandomInt1to3 FROM Get_RandInts)

	SET @HealthStatusName = (SELECT
	CASE @RandVal
	WHEN 1 THEN 'Major'
	WHEN 2 THEN 'Minor'
	WHEN 3 THEN 'Running'
	ELSE 'Other'
	END)

	RETURN @HealthStatusName;

END;