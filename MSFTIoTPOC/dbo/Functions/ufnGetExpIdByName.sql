CREATE FUNCTION [dbo].[ufnGetExpIdByName](@exp_name NVARCHAR(MAX))
    RETURNS int
AS
BEGIN

	DECLARE @exp_id int

	--use "TOP 1" to handle duplicate experience name matches
	SELECT @exp_id = (SELECT TOP 1 e.exp_id 
	FROM [dbo].[ExperienceCorrelation] e
	WHERE e.name = @exp_name);

	IF @exp_id IS NULL
	  BEGIN
	  	SELECT @exp_id = (SELECT TOP 1 e.exp_id
		FROM [dbo].[ExperienceCorrelation] e
		WHERE e.name = 'Other');
	  END

	RETURN @exp_id;
END