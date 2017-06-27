-- MSRETEL-367 (05.26.2017): fix asa job sql timeout issues by adding last_health_check_at to device health check

CREATE FUNCTION [dbo].[ufnDeriveSerialNumberFromIncomingTelemetry](@serial_number VARCHAR(50), @mac_address VARCHAR(50), @cs_name VARCHAR(50))
    RETURNS VARCHAR(50)
AS
BEGIN

    DECLARE @serial_number_derived VARCHAR(50)

	--not all manufacturers populate serial number
	IF ((@serial_number = '') OR (@serial_number = 'To be filled by O.E.M.') OR (@serial_number = 'Default string') OR (@serial_number = 'As printed in the D cover'))
		BEGIN
		  IF (@mac_address IS NOT NULL)
			 SET @serial_number_derived = REPLACE (@mac_address, ':', '');
		  ELSE
			 SET @serial_number_derived = @cs_name
		END
	ELSE
	    SET @serial_number_derived = @serial_number

	RETURN @serial_number_derived;
END