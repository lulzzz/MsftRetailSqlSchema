-- MSRETEL-116 (09.01.2016): updated to support new health status id functionality

CREATE FUNCTION dbo.ufnGetHealthStateFromPercentage (@type VARCHAR(1), @percentage INT)
RETURNS VARCHAR(50)
WITH EXECUTE AS CALLER
AS
BEGIN

    -- type "S" = "Store level health state percentage calculations"
	-- type "E" = "Experience level health state percentage calculations"

	DECLARE @HealthStateName VARCHAR(50)

	--SET @HealthStateName = ufnHealthStatePercentageThresholds(@type, @percentage)
	SET @HealthStateName = [dbo].[ufnHealthStatePercentageThresholds](@type, @percentage)

	RETURN @HealthStateName

END;