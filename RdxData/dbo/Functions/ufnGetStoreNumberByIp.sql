-- 06.26.2017 (MSRETEL-386): store assignment by ip

CREATE FUNCTION [dbo].[ufnGetStoreNumberByIp](@ip NVARCHAR(MAX))
    RETURNS int
AS
BEGIN
	DECLARE @ip_INT bigint = [dbo].[ufnIPAddressToInteger](@ip)
	DECLARE @store_number int = NULL;

	--use "TOP 1" to handle ip range overlap boundary scenarios
	SELECT @store_number = (SELECT TOP 1 s.Number
	FROM [dbo].[Stores] s
	JOIN [dbo].[IpRanges] ipr on ipr.StoreId = s.StoreId
	WHERE (@ip_INT >= [dbo].[ufnIPAddressToInteger](ipr.IpFrom)) AND
	      (@ip_INT <= [dbo].[ufnIPAddressToInteger](ipr.IpTo)))

	RETURN @store_number
END