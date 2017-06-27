-- MSRETEL-116 (09.01.2016): created this function to support new health status id functionality 

CREATE FUNCTION dbo.ufnHealthStatePercentageThresholds (@type VARCHAR(1), @percentage INT)
RETURNS VARCHAR(50)
WITH EXECUTE AS CALLER
AS
BEGIN

    -- @type "S" = "Store level health state percentage calculations"
	-- @type "E" = "Experience level health state percentage calculations"

	DECLARE @HealthStateName VARCHAR(50)

	IF (@type = 'S') 
	BEGIN

		IF (@percentage > 25)
		  SET @HealthStateName = 'Major'
		ELSE IF (@percentage <= 25 AND @percentage > 5)
		  SET @HealthStateName = 'Minor'
		ELSE
		  SET @HealthStateName = 'Running'

	END
	ELSE IF (@type = 'E')
	BEGIN

	    IF (@percentage > 25)
		  SET @HealthStateName = 'Major'
		ELSE IF (@percentage <= 25 AND @percentage > 5)
		  SET @HealthStateName = 'Minor'
		ELSE
		  SET @HealthStateName = 'Running'

	END

	RETURN @HealthStateName;

END;