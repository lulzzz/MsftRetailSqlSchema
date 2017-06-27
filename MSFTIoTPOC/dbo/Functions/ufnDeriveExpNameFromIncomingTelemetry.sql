-- MSRETEL-367 (05.26.2017): fix asa job sql timeout issues by adding last_health_check_at to device health check

CREATE FUNCTION [dbo].[ufnDeriveExpNameFromIncomingTelemetry](@cs_name VARCHAR(50), @rdx_rac VARCHAR(50), @exp_name VARCHAR(50))
    RETURNS VARCHAR(50)
AS
BEGIN

    DECLARE @exp_name_derived VARCHAR(50)

	--experience name should be derived from the following sources, in this priority:
	--  1.] Oculus LG hostname (i.e., @cs_name)
	--  2.] Make RDX RAC 'MRSUSEXP1' an exception to 3.]
	--  3.] RDX RAC (i.e., @rdx_rac)
	--  4.] Build tool reg key exp name entry (i.e., @exp_name)
	IF (@cs_name like 'LG-%')
	  SET @exp_name_derived = 'LGHOSTNAME'
	-- MSRETEL-311: RDX RAC 'MRSUSEXP1' is used by multiple experiences (e.g., standard demo, little bits), so don't use RDX RAC to determine exp name
	ELSE IF (@rdx_rac = 'MRSUSEXP1')
	  SET @exp_name_derived = @exp_name
	ELSE IF (@rdx_rac IS NOT NULL) 
	  SET @exp_name_derived = @rdx_rac
	ELSE
	  SET @exp_name_derived = @exp_name

	--account for non-demo devices (e.g., oobe)
	IF (@exp_name_derived IS NULL)
	BEGIN
	  SET @exp_name_derived = 'Other'
	END

	RETURN @exp_name_derived;
END