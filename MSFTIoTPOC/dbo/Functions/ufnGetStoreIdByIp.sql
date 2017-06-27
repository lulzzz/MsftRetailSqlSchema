CREATE FUNCTION [dbo].[ufnGetStoreIdByIp](@ip NVARCHAR(MAX))
    RETURNS int
AS
BEGIN
	DECLARE @ip_INT bigint = [dbo].[ufnIPAddressToInteger](@ip)
	DECLARE @store_id int = NULL;

	--use "TOP 1" to handle ip range overlap boundary scenarios
	SELECT @store_id = (SELECT TOP 1 s.StoreId 
	FROM [dbo].[Stores] s
	JOIN [dbo].[IpRanges] ipr on ipr.StoreId = s.StoreId
	WHERE (@ip_INT >= [dbo].[ufnIPAddressToInteger](ipr.IpFrom)) AND
	      (@ip_INT <= [dbo].[ufnIPAddressToInteger](ipr.IpTo)))

	RETURN @store_id
END