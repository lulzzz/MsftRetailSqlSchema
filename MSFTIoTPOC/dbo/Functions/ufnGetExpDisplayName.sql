CREATE FUNCTION [dbo].[ufnGetExpDisplayName](@exp_name VARCHAR(50))
    RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @exp_id INT
	DECLARE @exp_display_name VARCHAR(50)

	--use "TOP 1" to handle duplicate experience name matches
	SELECT @exp_id = (SELECT TOP 1 e.exp_id
	FROM [dbo].[ExperienceCorrelation] e
	WHERE e.name = @exp_name);

    SELECT @exp_display_name = (SELECT TOP 1 e.display_name
	FROM [dbo].[Experience] e
	WHERE e.id = @exp_id);

	-- default to 'Other' if not found
	IF @exp_display_name IS NULL
      SET @exp_display_name = 'Other'

	RETURN @exp_display_name;
END