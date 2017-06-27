-- 06.26.2017 (MSRETEL-382): ms fiscal year calculations

CREATE FUNCTION [dbo].[ufnConvertDateToMonth](@datetime DATETIME)
    RETURNS VARCHAR(6)
AS
BEGIN
	DECLARE @month VARCHAR(6) = NULL;

    SET @month = (CAST(RIGHT('0' + RTRIM(MONTH(@datetime)), 2) AS VARCHAR(2)) + CAST(YEAR(@datetime) AS VARCHAR(4)))

	RETURN @month;
END