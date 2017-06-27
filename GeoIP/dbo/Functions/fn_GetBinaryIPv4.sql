CREATE FUNCTION [dbo].[fn_GetBinaryIPv4](@ip AS NVARCHAR(15)) RETURNS BINARY(4)
AS 
BEGIN
	DECLARE @result BINARY(4)
	SELECT @result = CAST(
               CAST( CAST( PARSENAME( @ip, 4 ) AS INTEGER) AS BINARY(1))
            +  CAST( CAST( PARSENAME( @ip, 3 ) AS INTEGER) AS BINARY(1))
            +  CAST( CAST( PARSENAME( @ip, 2 ) AS INTEGER) AS BINARY(1))
            +  CAST( CAST( PARSENAME( @ip, 1 ) AS INTEGER) AS BINARY(1))
                AS BINARY(4))

	RETURN @result;
END