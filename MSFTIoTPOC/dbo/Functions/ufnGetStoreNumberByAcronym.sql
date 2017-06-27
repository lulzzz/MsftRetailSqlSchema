CREATE FUNCTION [dbo].[ufnGetStoreNumberByAcronym](@hostname NVARCHAR(MAX))
    RETURNS int
AS
BEGIN
	DECLARE @store_number int = NULL;
	DECLARE @store_acronym VARCHAR(10);

	--Grab store acronym from hostname
	set @store_acronym = REPLACE(substring(@hostname,charindex('-',@hostname)+1,4),'-','')

	--Add zero to a numeric store acronym (some stores misconfigure device names by removing a zero)
	if (ISNUMERIC(@store_acronym) = 1 and len(@store_acronym) = 3)
      SET @store_acronym = substring(@store_acronym, 1,1) + '0' + substring(@store_acronym, 2,2)

	--Find store number using store acronym 
	SELECT @store_number = (SELECT TOP 1 s.Number
	FROM [dbo].[Stores] s
	WHERE s.CexAcronym = @store_acronym)

	RETURN @store_number
END