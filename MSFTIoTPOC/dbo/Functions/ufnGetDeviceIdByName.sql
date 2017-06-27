CREATE FUNCTION [dbo].[ufnGetDeviceIdByName](@device_name VARCHAR(50))
    RETURNS int
AS
BEGIN
	DECLARE @device_id int = NULL;

	--use "TOP 1" to handle duplicate device name matches
	SELECT @device_id = (SELECT TOP 1 d.device_id
	FROM [dbo].[Device] d
	WHERE d.cs_name = @device_name);

	RETURN @device_id;
END