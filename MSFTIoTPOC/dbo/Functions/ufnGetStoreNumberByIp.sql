-- MSRETEL-171 (11.21.2016): ipv4 address enforcement to prevent this error: "error converting data type nvarchar to bigint"

CREATE FUNCTION [dbo].[ufnGetStoreNumberByIp](@ip NVARCHAR(MAX), @external_ip NVARCHAR(MAX))
    RETURNS int
AS
BEGIN

    -- make sure the ip addresses are v4 - if not, default them to 0.0.0.0
    DECLARE @validated_ip_private VARCHAR(50), @validated_ip_external VARCHAR(50)

	SET @validated_ip_private = @ip
	SET @validated_ip_external = @external_ip

	IF (@validated_ip_private NOT LIKE '%_.%_.%_.%_') 
	    SET @validated_ip_private = '0.0.0.0'
	
	IF (@validated_ip_external NOT LIKE '%_.%_.%_.%_')
	    SET @validated_ip_external = '0.0.0.0'
    
	DECLARE @ip_INT bigint = [dbo].[ufnIPAddressToInteger](@validated_ip_private)
	DECLARE @ext_ip_INT bigint = [dbo].[ufnIPAddressToInteger](@validated_ip_external)
	DECLARE @store_number int = NULL;

	--use "TOP 1" to handle ip range overlap boundary scenarios
	SELECT @store_number = (SELECT TOP 1 s.Number
	FROM [dbo].[Stores] s
	JOIN [dbo].[IpRanges] ipr on ipr.StoreId = s.StoreId
	WHERE (@ip_INT >= [dbo].[ufnIPAddressToInteger](ipr.IpFrom)) AND
	      (@ip_INT <= [dbo].[ufnIPAddressToInteger](ipr.IpTo)))

    --if no store is found, try using the external ip address (i.e., speciality stores)
	if (@store_number IS NULL)
	BEGIN
		SELECT @store_number = (SELECT TOP 1 s.Number
		FROM [dbo].[Stores] s
		JOIN [dbo].[IpRanges] ipr on ipr.StoreId = s.StoreId
		WHERE (@ext_ip_INT >= [dbo].[ufnIPAddressToInteger](ipr.IpFrom)) AND
			  (@ext_ip_INT <= [dbo].[ufnIPAddressToInteger](ipr.IpTo)))
	END

	RETURN @store_number
END