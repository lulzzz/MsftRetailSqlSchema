CREATE PROCEDURE [dbo].[sp_GetCityByIp](@ip NVARCHAR(MAX))
AS
BEGIN
	
	DECLARE @IpIsZeroBased BIT 
	
	IF (PARSENAME(@ip, 4) = 0)
		SET @IpIsZeroBased = 1

	DECLARE @ip_INT INT
	SET @ip_INT = CAST([dbo].[fn_GetBinaryIPv4](@ip) AS INT)
	
	SELECT c.* 
	FROM Cities c
	JOIN IpRanges ipr on ipr.CityId = c.CityId
	WHERE 
		@ip_INT >= (CASE WHEN @IpIsZeroBased =  1 THEN ipr.IpFrom_ZeroBased_INT ELSE ipr.IpFrom_INT END) AND
		@ip_INT <= (CASE WHEN @IpIsZeroBased =  1 THEN ipr.IpTo_ZeroBased_INT ELSE ipr.IpTo_INT END)
END