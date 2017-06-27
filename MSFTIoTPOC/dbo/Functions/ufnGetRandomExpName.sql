CREATE FUNCTION dbo.ufnGetRandomExpName (@ExpAcronym VARCHAR(5))
RETURNS VARCHAR(50)
WITH EXECUTE AS CALLER
AS
BEGIN

	DECLARE @ExpName VARCHAR(50)

	SET @ExpName = (SELECT
	CASE @ExpAcronym
	WHEN 'D' THEN 'Standard Demo'
	WHEN 'O' THEN 'Office Demo'
	WHEN 'V' THEN 'Digital Signage'
	WHEN 'I' THEN 'Immersive Demo'
	WHEN 'C' THEN 'Connected Story'
	WHEN 'H' THEN 'Hololens'
	ELSE 'Other'
	END)

	RETURN @ExpName;

END;