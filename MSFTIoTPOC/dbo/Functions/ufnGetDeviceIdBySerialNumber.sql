CREATE FUNCTION [dbo].[ufnGetDeviceIdBySerialNumber](@serial_number VARCHAR(50))
    RETURNS int
AS
BEGIN
	DECLARE @device_id int = NULL;

	--use "TOP 1" to handle duplicate device name matches
	SELECT @device_id = (SELECT TOP 1 d.device_id
	FROM [dbo].[Device] d
	WHERE d.serial_number = @serial_number);

	RETURN @device_id;
END