CREATE FUNCTION [dbo].[ufnGetStoreNumberByNetworkId](@net_id NVARCHAR(MAX))
    RETURNS int
AS
BEGIN
	--DECLARE @ip_INT bigint = [dbo].[ufnIPAddressToInteger](@ip)
	--DECLARE @ext_ip_INT bigint = [dbo].[ufnIPAddressToInteger](@external_ip)
	DECLARE @store_number int = NULL;

	SELECT @store_number = (SELECT TOP 1 s.Number
	FROM [dbo].[Stores] s
	JOIN [dbo].[IpRanges] ipr on ipr.StoreId = s.StoreId
	WHERE (ipr.NetworkId = @net_id) )

	RETURN @store_number
END