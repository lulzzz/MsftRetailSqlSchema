CREATE FUNCTION dbo.ufnGetHealthStateIdFromPercentage (@type VARCHAR(1), @percentage INT)
RETURNS INT
WITH EXECUTE AS CALLER
AS
BEGIN

    -- type "S" = "Store level health state percentage calcuations"
	-- type "E" = "Experience level health state percentage calcuations"

	DECLARE @HealthStateName VARCHAR(50)
	DECLARE @HealthStateId INT

	SET @HealthStateName = [dbo].[ufnHealthStatePercentageThresholds](@type, @percentage)

	SET @HealthStateId = (SELECT id from HealthState where name = @HealthStateName)

	RETURN @HealthStateId

END;