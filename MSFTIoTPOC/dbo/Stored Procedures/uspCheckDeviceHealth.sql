-- MSRETEL-367 (05.26.2017): fix asa job sql timeout issues by adding last_health_check_at to device health check

CREATE PROCEDURE [dbo].[uspCheckDeviceHealth]
AS
BEGIN

DECLARE @last_health_check_at DATETIME, @device_id INT, @exp_id INT, @store_number INT
DECLARE @manufacturer VARCHAR(50), @model VARCHAR(50), @exp_buildtool_version VARCHAR(50)
DECLARE @cs_name VARCHAR(50), @adobe_installed INT, @office_version INT, @rdx_rac VARCHAR(50)
DECLARE @en_ca_enabled INT, @run_health_check BIT, @demo_category INT

DECLARE Device_Cursor CURSOR FOR 
	SELECT 
	  last_health_check_at, device_id, exp_id, store_number, model, exp_buildtool_version, 
	  cs_name, adobe_installed, office_version, rdx_rac, en_ca_enabled, demo_category
	FROM Device where modified_at >= DATEADD(DAY,-1,GETDATE()) AND
	((last_health_check_at <= DATEADD(MINUTE,-1,GETDATE())) OR (last_health_check_at IS NULL) )

OPEN Device_Cursor 

FETCH NEXT FROM Device_Cursor INTO
	  @last_health_check_at, @device_id, @exp_id, @store_number, @model, @exp_buildtool_version, 
	  @cs_name, @adobe_installed, @office_version, @rdx_rac, @en_ca_enabled, @demo_category

WHILE @@FETCH_STATUS = 0
BEGIN
    
	--SET @run_health_check = 'false'
	--IF ( (@last_health_check_at <= DATEADD(DAY,-1,@last_health_check_at)) OR (@last_health_check_at IS NULL) )
	--  SET @run_health_check = 'true'
	
	IF (@device_id IS NOT NULL)
	BEGIN
		PRINT convert(varchar(25), getdate(), 121) + 'start_health_monitor_check'
	    IF ((@device_id IS NOT NULL) AND (@exp_id IS NOT NULL) AND (@store_number IS NOT NULL) AND (@demo_category = 1))
	    BEGIN
	        EXEC dbo.uspRunHealthMonitors @device_id, @exp_id, @store_number, @model, @exp_buildtool_version, @cs_name, @adobe_installed, @office_version, @rdx_rac, @en_ca_enabled
	        PRINT convert(varchar(25), getdate(), 121) + 'end_health_monitor_check'

	        --calculate device level experience health state
	        IF (@device_id IS NOT NULL)
	        BEGIN
	            PRINT convert(varchar(25), getdate(), 121) + 'start_uspCalculateDeviceExpHealthState'
	            EXEC dbo.uspCalculateDeviceExpHealthState @device_id, @exp_id
		        PRINT convert(varchar(25), getdate(), 121) + 'end_uspCalculateDeviceExpHealthState'
	        END

			UPDATE dbo.Device SET last_health_check_at = getdate() WHERE device_id = @device_id
	    END

		--MSRETEL-314 (03.16.2017) - Remove deprecated store & experience health state info
		--update store and experience level health state
		IF ((@store_number IS NOT NULL) AND (@exp_id IS NOT NULL))
			EXEC [dbo].uspUpdateStoreAndExpHealth @store_number, @exp_id
	END
	
	FETCH NEXT FROM Device_Cursor INTO
	  @last_health_check_at, @device_id, @exp_id, @store_number, @model, @exp_buildtool_version, 
	  @cs_name, @adobe_installed, @office_version, @rdx_rac, @en_ca_enabled, @demo_category

END

CLOSE Device_Cursor 
DEALLOCATE Device_Cursor

END