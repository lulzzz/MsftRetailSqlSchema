-- MSRETEL-115 (08.29.2016): add device model to uspRunHealthMonitors parameter list
-- MSRETEL-113 (09.16.2016): add oculus device name to experience derivement conditional logic
-- MSRETEL-098 (09.22.2016): add @exp_buildtool_version to uspRunHealthMonitors argument list
-- MSRETEL-096 (09.22.2016): add @cs_name to uspRunHealthMonitors argument list
-- MSRETEL-074 (10.03.2016): add adobe 2015 installation logic
-- MSRETEL-174 (11.09.2016): add @processor_name to uspRunHealthMonitors argument list
-- MSRETEL-171 (11.21.2016): add additional debug info for ASA job troubleshooting (e.g., "Error converting data type nvarchar to bigint")
-- MSRETEL-269 (01.13.2017): process office 365 version info into SQL
-- MSRETEL-270 (01.13.2017): Office 365 needs to be at a minimum version - otherwise, it is defined as "outdated"
-- MSRETEL-270 (01.20.2017): We only care about Office 365 on RDX enabled devices (e.g., kiosk mode devices don't need office)
-- MSRETEL-311 (03.08.2017): Account for RDX RAC 'MRSUSEXP1' being used by multiple experiences (e.g., standard demo, little bits)
-- MSRETEL-313 (03.16.2017): Add device categorizations (@demo_category) (e.g., isolate community demo devices from foh demo devices)
-- MSRETEL-314 (03.16.2017): Remove deprecated store/health code
-- MSRETEL-315 (03.24.2017): Tag devices with 'en-ca' system locale profile
-- MSRETEL-346 (04.20.2017): add microsoft account info
-- MSRETEL-366 (05.19.2017): capture daily device history state
-- MSRETEL-367 (05.26.2017): fix asa job sql timeout issues by adding last_health_check_at to device health check
-- MSRETEL-369 (06.02.2017): add os build & install date to device tracking
-- MSRETEL-370 (06.05.2017): run health check every 24 hours instead of every time the device sends telemetry (every 4 hours)
-- MSRETEL-383 (06.18.2017): add customer_id to device history

CREATE PROCEDURE [dbo].[uspProcessDeviceMessage]
AS
BEGIN

DECLARE @dma_id INT, @created_at DATETIME, @caption VARCHAR(50), @cs_name VARCHAR(50) 
DECLARE @manufacturer VARCHAR(50), @model VARCHAR(50), @total_physical_memory VARCHAR(50)
DECLARE @ip_address_v4 VARCHAR(50), @serial_number VARCHAR(50), @exp_name VARCHAR(50), @exp_buildtool_version VARCHAR(50)
DECLARE @store_number INT, @os_build_number INT, @rdx_rac VARCHAR(50), @rdx_sku VARCHAR(50)
DECLARE @exp_id INT, @exp_display_name VARCHAR(50), @device_id INT, @result INT, @exp_name_derived VARCHAR(50)
DECLARE @external_ip VARCHAR(50), @wlan_ssid VARCHAR(50), @rdx_sku_derived VARCHAR(50), @time_zone VARCHAR(50)
DECLARE @serial_number_derived VARCHAR(50), @mac_address VARCHAR(50), @processor_name VARCHAR(100)
DECLARE @adobe_result INT, @adobe_version VARCHAR(50), @adobe_installed INT, @demo_category INT, @en_ca_enabled INT
DECLARE @office_build VARCHAR(50), @office_release_ids VARCHAR(150), @office_platform VARCHAR(50), @office_version INT
DECLARE @microsoft_account VARCHAR(100), @local_account VARCHAR(100), @stored_identities INT, @health_state_id INT
DECLARE @t_last_health_check_at DATETIME, @run_health_check BIT, @t_health_state_id INT, @os_install_date VARCHAR(50)


DECLARE DeviceMessageAsa_Cursor CURSOR FOR 
	SELECT id, created_at, caption, os_build_number, os_install_date, cs_name, manufacturer, model, total_physical_memory, ip_address_v4, 
	       mac_address ,serial_number, rdx_rac, rdx_sku, exp_name, demo_category, en_ca_enabled, exp_buildtool_version, external_ip,  
		   wlan_ssid, time_zone, adobe_result, adobe_version,office_build, office_release_ids, office_platform, processor_name,
		   microsoft_account, local_account, stored_identities
    FROM DeviceMessageAsa WHERE processed = 0

OPEN DeviceMessageAsa_Cursor 

FETCH NEXT FROM DeviceMessageAsa_Cursor INTO
    @dma_id, @created_at, @caption, @os_build_number, @os_install_date, @cs_name, @manufacturer, @model, @total_physical_memory, @ip_address_v4, @mac_address, @serial_number, 
	@rdx_rac, @rdx_sku, @exp_name, @demo_category, @en_ca_enabled, @exp_buildtool_version, @external_ip, @wlan_ssid, @time_zone, @adobe_result, 
	@adobe_version, @office_build, @office_release_ids, @office_platform, @processor_name, 
	@microsoft_account, @local_account, @stored_identities

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT convert(varchar(25), getdate(), 121) + 'START: ' + @cs_name
	/***********************************************************************************************
	 * Cleanup incoming telemetry 
	 ***********************************************************************************************/
	SET @rdx_rac = (UPPER(@rdx_rac))
	
	IF (@rdx_sku = '' OR @rdx_sku = 'NotFound')
	  SET @rdx_sku_derived = NULL
	ELSE
	  SET @rdx_sku_derived = @rdx_sku

	/***********************************************************************************************
	 * Derive demo experience from incoming telemetry
	 ***********************************************************************************************/
	SET @exp_name_derived = [dbo].[ufnDeriveExpNameFromIncomingTelemetry](@cs_name, @rdx_rac, @exp_name)
	SET @exp_id = [dbo].[ufnGetExpIdByName](@exp_name_derived)
	SET @exp_display_name = [dbo].[ufnGetExpDisplayName](@exp_name_derived)

	/***********************************************************************************************
	 * Derive serial number from incoming telemetry
	 ***********************************************************************************************/
	SET @serial_number_derived = [dbo].[ufnDeriveSerialNumberFromIncomingTelemetry](@serial_number, @mac_address, @cs_name)
	
	/***********************************************************************************************
	 * Derive store number from incoming telemetry
	 ***********************************************************************************************/
	SET @store_number = [dbo].[ufnGetStoreNumberByIp](@ip_address_v4, @external_ip)
	IF (@store_number IS NULL)
	    SET @store_number = [dbo].[ufnGetStoreNumberByAcronym](@cs_name)

	/***********************************************************************************************
	* Derive adobe install state from incoming telemetry
	***********************************************************************************************/
	SET @adobe_installed = [dbo].[ufnCheckIfAdobeInstalled](@adobe_result, @adobe_version)

	/***********************************************************************************************
	* Derive office version from incoming telemetry
	***********************************************************************************************/
	SET @office_version = [dbo].[ufnGetOfficeVersionFromBuildNumber](@office_build)
	
	/***********************************************************************************************
	* Update device state
	***********************************************************************************************/
	UPDATE dbo.Device SET cs_name = @cs_name, os_build_number = @os_build_number, os_install_date = @os_install_date, ip_address_v4 = @ip_address_v4, store_number = @store_number, 
	rdx_rac = @rdx_rac, rdx_sku = @rdx_sku_derived, exp_id = @exp_id, exp_name = @exp_display_name, demo_category = @demo_category,
	exp_buildtool_version = @exp_buildtool_version, external_ip = @external_ip, wlan_ssid = @wlan_ssid, time_zone = @time_zone, 
	adobe_installed = @adobe_installed, serial_number = @serial_number_derived, office_build = @office_build, 
	office_release_ids = @office_release_ids, office_platform = @office_platform, office_version = @office_version,
	processor_name = @processor_name, dbo.Device.modified_at = GETDATE(), en_ca_enabled = @en_ca_enabled,
	microsoft_account = @microsoft_account, local_account = @local_account, stored_identities = @stored_identities
	WHERE dbo.Device.serial_number = @serial_number_derived;
	
	--insert the device if it does not exist
	IF @@ROWCOUNT=0
		
		INSERT INTO dbo.Device (created_at, modified_at, last_health_check_at, caption, os_build_number, 
		os_install_date, cs_name, manufacturer, model, total_physical_memory, ip_address_v4, 
		store_number, serial_number, rdx_rac, rdx_sku, exp_id, exp_name, demo_category, 
		exp_buildtool_version, external_ip, wlan_ssid, time_zone, adobe_installed, 
		office_build, office_release_ids, office_platform, office_version, processor_name, 
		microsoft_account, local_account, stored_identities, en_ca_enabled) VALUES 
		(@created_at, GETDATE(), DATEADD(DAY,-1,GETDATE()), @caption, @os_build_number, @os_install_date, @cs_name,
		@manufacturer, @model, @total_physical_memory, @ip_address_v4, 
		@store_number, @serial_number_derived, @rdx_rac, @rdx_sku_derived, @exp_id, @exp_display_name, 
		@demo_category, @exp_buildtool_version, @external_ip, @wlan_ssid, @time_zone, @adobe_installed, 
		@office_build, @office_release_ids, @office_platform, @office_version ,@processor_name,
		@microsoft_account, @local_account, @stored_identities, @en_ca_enabled); 


	/***********************************************************************************************
	* Retrieve device id
	***********************************************************************************************/
	SET @device_id = [dbo].[ufnGetDeviceIdByName](@cs_name)
	IF @device_id IS NULL
	  SET @device_id = [dbo].[ufnGetDeviceIdBySerialNumber](@serial_number_derived)
	
	--PRINT convert(varchar(25), getdate(), 121) + 'ex_derived: ' + @exp_name_derived
	--PRINT convert(varchar(25), getdate(), 121) + 'sn_derived: ' + @serial_number_derived
	--PRINT convert(varchar(25), getdate(), 121) + 'device_id:  ' + CAST(@device_id as VARCHAR(50))


	/****************************************************************************************************
	* Check device health
	****************************************************************************************************/
	--PRINT convert(varchar(25), getdate(), 121) + 'START device health check logic'
	--run individual experience health monitor checks
	--MSRETEL-115 (08.29.2016): add @model
	--MSRETEL-074 (10.03.2016): add @adobe_installed
	--MSRETEL-270 (01.13.2017): add @office_version 
	--MSRETEL-270 (01.20.2017): add @rdx_rac
	--MSRETEL-313 (03.16.2017): only run health monitor rules agains FOH demo devices (e.g., exclude community devices)

    SET @t_last_health_check_at = (select top 1 last_health_check_at from Device where device_id = @device_id)

    SET @run_health_check = 'false'
	IF ( (@t_last_health_check_at <= DATEADD(HOUR,-24,GETDATE())) OR (@t_last_health_check_at IS NULL) )
	  SET @run_health_check = 'true'

	IF ((@run_health_check = 'true') AND (@device_id IS NOT NULL) AND (@demo_category = 1))
	BEGIN
		--PRINT convert(varchar(25), getdate(), 121) + 'start_health_monitor_check'
	    IF ((@device_id IS NOT NULL) AND (@exp_id IS NOT NULL) AND (@store_number IS NOT NULL))
	    BEGIN
	        EXEC dbo.uspRunHealthMonitors @device_id, @exp_id, @store_number, @model, @exp_buildtool_version, @cs_name, @adobe_installed, @office_version, @rdx_rac, @en_ca_enabled
	        --PRINT convert(varchar(25), getdate(), 121) + 'end_health_monitor_check'

	        --calculate device level experience health state
	        IF (@device_id IS NOT NULL)
	        BEGIN
	            --PRINT convert(varchar(25), getdate(), 121) + 'start_uspCalculateDeviceExpHealthState'
	            EXEC @health_state_id = dbo.uspCalculateDeviceExpHealthState @device_id, @exp_id
		        --PRINT convert(varchar(25), getdate(), 121) + 'end_uspCalculateDeviceExpHealthState'
	        END

			UPDATE dbo.Device SET last_health_check_at = getdate() WHERE device_id = @device_id
	    END
	END

	--PRINT convert(varchar(25), getdate(), 121) + 't_last_health_check_at:  ' + CAST(@t_last_health_check_at as varchar(50))
	--PRINT convert(varchar(25), getdate(), 121) + 'END device health check logic'


	/****************************************************************************************************
	* Update store and experience health state
	****************************************************************************************************/
	IF ((@store_number IS NOT NULL) AND (@exp_id IS NOT NULL)) --MSRETEL-314 (03.16.2017)
		EXEC [dbo].uspUpdateStoreAndExpHealth @store_number, @exp_id

	/****************************************************************************************************
	* Record device history
	****************************************************************************************************/
	--PRINT convert(varchar(25), getdate(), 121) + 'START device history logic'
	IF (@device_id IS NOT NULL) -- MSRETEL-366 (05.19.2017)
	BEGIN
	    SET @t_health_state_id = (select top 1 health_state_id from Device where device_id = @device_id)
		--PRINT convert(varchar(25), getdate(), 121) + 'start_uspCaptureDeviceHistory'
		EXEC [dbo].[uspCaptureDeviceHistory] @device_id, @cs_name, @os_build_number, @os_install_date, @ip_address_v4, @serial_number_derived, @store_number, @rdx_rac, @rdx_sku, 
		@exp_buildtool_version, @exp_id, @t_health_state_id, @external_ip, @wlan_ssid, @microsoft_account, @local_account, @demo_category
		--PRINT convert(varchar(25), getdate(), 121) + 'end_uspCaptureDeviceHistory'
	END
	--PRINT convert(varchar(25), getdate(), 121) + 'END device history logic'

	/****************************************************************************************************
	* Mark incoming telemetry as processed
	****************************************************************************************************/
	UPDATE dbo.DeviceMessageAsa SET processed = 1 WHERE cs_name = @cs_name and processed = 0;

	--PRINT convert(varchar(25), getdate(), 121) + 'END: ' + @cs_name

	FETCH NEXT FROM DeviceMessageAsa_Cursor INTO
	@dma_id, @created_at, @caption, @os_build_number, @os_install_date, @cs_name, @manufacturer, @model, @total_physical_memory, @ip_address_v4, @mac_address, @serial_number, 
	@rdx_rac, @rdx_sku, @exp_name, @demo_category, @en_ca_enabled, @exp_buildtool_version, @external_ip, @wlan_ssid, @time_zone, @adobe_result, 
	@adobe_version, @office_build, @office_release_ids, @office_platform, @processor_name,
	@microsoft_account, @local_account, @stored_identities
END

CLOSE DeviceMessageAsa_Cursor 
DEALLOCATE DeviceMessageAsa_Cursor

END