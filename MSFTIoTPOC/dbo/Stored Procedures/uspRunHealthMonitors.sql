-- MSRETEL-062 (08.17.2016): revised business rule - health monitor rules now apply to ALL demo experiences by default
-- MSRETEL-115 (08.29.2016): added health monitor rule exception for X51 devices (Oculus X51 devices should not be upgraded to RS1)
-- MSRETEL-116 (09.01.2016): updated to support new health status id
-- MSRETEL-138 (09.07.2016): localize health monitor *expected* results
-- MSRETEL-146 (09.08.2016): remove dependency on HealthMonitor.health_state (this column is being dropped)
-- MSRETEL-072 (09.16.2016): adjust actual result of build tool monitor to 'None' if actual result is null
-- MSRETEL-098 (09.22.2016): add "old usb" health monitor (devices need to be built with a required minimum build tool version number)
-- MSRETEL-096 (09.22.2016): add "media lounge" health monitor (media lounges must be configured with the media lounge RDX RAC)
-- MSRETEL-074 (10.03.2016): add "adobe 2015 installation" health monitor for surface books
-- MSRETEL-170 (10.31.2016): Oculus devices should be excluded from time zone monitor
-- MSRETEL-270 (01.13.2017): Office 365 needs to be at a minimum version - otherwise, it is defined as "outdated"
-- MSRETEL-270 (01.20.2017): We only care about Office 365 on RDX enabled devices (e.g., kiosk mode devices don't need office)
-- MSRETEL-295 (02.08.2017): Fix WIN10RS1 rule so that newer windows versions are not flagged
-- MSRETEL-300 (02.16.2017): Office version rule expected value should show "1611 or newer"
-- MSRETEL-309 (03.01.2017): Bug fix for office installs upgraded from flagged old version to newly released version that is unknown to RED
-- MSRETEL-312 (03.08.2017): Beauty and the Beast (BatB) devices not configured with build tool, so need to make BatB an exception to this rule
-- MSRETEL-315 (03.24.2017): Tag devices with 'en-ca' system locale profile
-- MSRETEL-330 (04.05.2017): Add RS2 "Windows 10 Creators Update" rule
-- MSRETEL-345 (05.02.2017): Allow retail stores to have multiple valid time zones
-- MSRETEL-368 (05.30.2017): Add new AdminWLAN (so we can highlight on MS RED Overview Power BI report)

CREATE PROCEDURE [dbo].[uspRunHealthMonitors]
  @device_id INT,
  @exp_id INT,
  @store_number INT,
  @device_model VARCHAR(50),
  @exp_buildtool_version VARCHAR(50),
  @cs_name VARCHAR(50),
  @adobe_installed INT,
  @office_version INT,
  @rdx_rac VARCHAR(50),
  @en_ca_enabled INT
AS
BEGIN

	DECLARE @title VARCHAR(50), @expected VARCHAR(50), @msg_fail VARCHAR(50), @health_state VARCHAR(50)
	DECLARE @monitor_name VARCHAR(50), @actual VARCHAR(50), @hm_id INT, @hm_expected VARCHAR(50)
	DECLARE @health_state_running_id INT, @health_state_minor_id INT, @health_state_major_id INT
	DECLARE @health_state_id INT,  @exp_buildtool_minor_version VARCHAR(50), @os_build_number_int INT
	DECLARE @countryName VARCHAR(100)

	-- MSRETEL-116 (09.01.2016): retrieve health monitor ids
    SET @health_state_running_id = (SELECT id from HealthState where name = 'Running');
	--SET @health_state_minor_id = (SELECT id from HealthState where name = 'Minor');
	SET @health_state_major_id = (SELECT id from HealthState where name = 'Major');

	SET @countryName = (select top 1 CountryName from vwActiveStore where StoreNumber = @store_number)

	--MSRETEL-062 (08.17.2016): list all active health monitors (health monitors apply to all demo experiences)
	--MSRETEL-146 (09.08.2016): remove dependency on HealthMonitor.health_state (this column is being dropped)
	DECLARE HealthMonitor_Cursor CURSOR FOR 
	SELECT hm.id, hm.name, hm.title, hm.message_fail, hs.name as 'health_state_name', hm.health_state_id, hm.expected
	FROM [dbo].[HealthMonitor] hm, [dbo].[HealthState] hs
	WHERE hm.active = 1 and hm.health_state_id = hs.id
	
	--iterate the list of health monitors and run each health monitor
	--09.07.2016: @hm_expected is the default health monitor expected value
	--            this can be overriden with a localized expected value if needed (example: expected local time zones)
	OPEN HealthMonitor_Cursor 
	FETCH NEXT FROM HealthMonitor_Cursor INTO
		@hm_id, @monitor_name, @title, @msg_fail, @health_state, @health_state_id, @hm_expected

	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		IF (@monitor_name = 'WIN10RS1')
		--IF ((@monitor_name = 'WIN10RS1') AND (@store_number = 0))
		BEGIN
		    SET @os_build_number_int = CONVERT(INT, @hm_expected)
			SELECT @actual = (SELECT TOP 1 d.os_build_number FROM [dbo].[Device] d WHERE d.device_id = @device_id);
			--Alienware for HTC Vive (exp 18) and media lounge (exp 13) should not be upgraded to RS1
			--Oculus Alienware X51 devices should not be upgraded to RS1 (MSRETEL-115 - 08.29.2016)
			--IF ((@actual = '14393') OR (@exp_id = 18) OR (@exp_id = 13) OR (@device_model like '%Alienware X51%'))
			IF ((@actual >= @os_build_number_int ) OR (@exp_id = 18) OR (@exp_id = 13) OR (@device_model like '%Alienware X51%'))
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 0, @health_state, @health_state_id
		END
		ELSE IF (@monitor_name = 'DemoNet')
		BEGIN
		    SELECT @actual = (SELECT TOP 1 d.wlan_ssid FROM [dbo].[Device] d WHERE d.device_id = @device_id);
			-- a null wlan_ssid implies a wired connection
			IF ((lower(@actual) = lower(@hm_expected)) OR (@actual IS NULL) )
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			ELSE 
			BEGIN
			  IF (lower(@actual) = 'seca') -- 05.30.2017 - moved seca to new alert (see below)
			    --EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 0, 'Major', @health_state_major_id
				EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			  ELSE IF (lower(@actual) = 'microsoft store')
			    EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			  --xbox (11), gaming (2), minecraft (9), and some standard (1) demos are ok to be connected to homenet
			  ELSE IF ((lower(@actual) = 'homenet') AND ( (@exp_id = 1) OR (@exp_id = 2) OR (@exp_id =9) OR (@exp_id =11) ))
			    EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			  ELSE
			    EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 0, @health_state, @health_state_id
			END
		END
	    ELSE IF (@monitor_name = 'BuildToolVersion')
		BEGIN
		    SELECT @actual = (SELECT TOP 1 d.exp_buildtool_version FROM [dbo].[Device] d WHERE d.device_id = @device_id);
			--MSRETEL-312 (03.08.2017) - Beauty and the Beast (BatB) devices not configured with build tool, so need to make BatB an exception to this rule
			IF ((@actual IS NOT NULL) OR (@exp_id = 22))
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			ELSE 
			  -- MSRETEL-072 (09.16.2016): adjust actual result of build tool monitor to 'None' if actual result is null
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, 'None', @hm_expected, 0, @health_state, @health_state_id
		END
	    ELSE IF (@monitor_name = 'TimeZone')
		BEGIN
		    DECLARE @result_time_zone INT
		    SELECT @actual = (SELECT TOP 1 d.time_zone FROM [dbo].[Device] d WHERE d.device_id = @device_id);
		    --SELECT @expected = (SELECT TOP 1 s.TimeZone FROM [dbo].[Stores] s WHERE s.Number = @store_number);
			-- MSRETEL-345 (05.02.2017): allow retail stores to have multiple valid time zones
			SET @expected = (SELECT TOP 1 TimeZone FROM [dbo].[StoreTimeZones] WHERE StoreNumber = @store_number)
			SET @result_time_zone = (SELECT count(TimeZone) FROM [dbo].[StoreTimeZones] WHERE StoreNumber = @store_number AND TimeZone = @actual)
			IF ((@result_time_zone > 0) OR (@cs_name like 'LG%')) -- MSRETEL-170 (10.31.2016)
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @expected, 1, 'Running', @health_state_running_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @expected, 0, @health_state, @health_state_id
		END
	    ELSE IF (@monitor_name = 'MRSRACS')
		BEGIN
		    SELECT @actual = (SELECT TOP 1 d.rdx_rac FROM [dbo].[Device] d WHERE d.device_id = @device_id);
		    --non-mrs rdx rac testing (e.g., PMDEMO, COINATTRACTHUBRS) often done in store 0
			IF ((lower(@actual) LIKE 'mrs%') OR (lower(@actual) = 'cspclab') OR (@actual IS NULL) OR (@store_number = 0))
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 0, @health_state, @health_state_id
		END

		-- Demo devices must be built with a minimum required build tool version 
	    ELSE IF (@monitor_name = 'OldBuildTool')
		BEGIN
		    DECLARE @buildtool_number_decimal DECIMAL(10,3) = NULL
			DECLARE @buildtool_number_string VARCHAR(50) = NULL
			DECLARE @buildtool_number_decimal_expected DECIMAL(10,3) = NULL -- version number the build tool should be at

			--evaluate the build tool version number of this device, as long as 
			-- 1.) the expected version number (e.g., "2.1") is numeric
			-- 2.) the device is not running an htc vive (18) or oculus (20) experience (a different build tool version was used for these devices)
			IF ((@hm_expected IS NOT NULL) AND (ISNUMERIC(@hm_expected) = 1) AND (@exp_id != 18) AND (@exp_id != 20) )
			  BEGIN
			    SET @buildtool_number_decimal_expected = CAST(@hm_expected AS DECIMAL(10, 3)) 
				--parse out the version number (e.g., "2.0") from the device's build tool version string (e.g., "2.0_08222016")
				SET @buildtool_number_decimal = [dbo].[ufnGetVersionNumberFromBuildToolVersion](@exp_buildtool_version)
				
				--run the health monitor conditional logic as long as the device has a build tool version number that is not null
				IF (@buildtool_number_decimal IS NOT NULL)
				BEGIN
				    SET @buildtool_number_string = CAST(@buildtool_number_decimal AS VARCHAR(50)) -- actual build tool version number
					--record an alert if the build tool version number is older than the current version number
					IF (@buildtool_number_decimal < @buildtool_number_decimal_expected)
					  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @buildtool_number_string, @hm_expected, 0, @health_state, @health_state_id
					ELSE
					  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @buildtool_number_string, @hm_expected, 1, 'Running', @health_state_running_id
				END
			  END
		END
		-- Media Lounges (ML) required to be configured with ML RDX RAC 
	    ELSE IF (@monitor_name = 'MLRDXRAC')
		BEGIN
		    SELECT @actual = (SELECT TOP 1 d.rdx_rac FROM [dbo].[Device] d WHERE d.device_id = @device_id);

			IF ( (lower(@actual) != lower(@hm_expected)) AND (@cs_name like 'ML%'))
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 0, @health_state, @health_state_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id

		END
		-- MSRETEL-074 (10.03.2016): Surface Books (SB) must have Adobe installed
	    ELSE IF (@monitor_name = 'ADOBESB')
		BEGIN
			-- see 'ufnCheckIfAdobeInstalled' for adobe installation check logic
			IF ( (@adobe_installed = 2 ) AND (@device_model = 'Surface Book'))
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, 'Adobe Not Installed', @hm_expected, 0, @health_state, @health_state_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, 'Adobe Installed', @hm_expected, 1, 'Running', @health_state_running_id

		END

		-- MSRETEL-270 (01.13.2017) - Minimum Office 365 version required
	    ELSE IF (@monitor_name = 'OFFICE365VER')
		BEGIN
		  
		  -- MSRETEL-270 (01.13.2017) - We currently don't care about devices not running Office
          IF (@office_version IS NOT NULL)
		  BEGIN
		    DECLARE @office_version_expected_int INT, @office_version_actual_string VARCHAR(50)
			SET @office_version_expected_int = CONVERT(INT, @hm_expected)
			SET @office_version_actual_string = CONVERT(varchar(50), @office_version)
			-- MSRETEL-270 (01.20.2017) - We only care about Office 365 on RDX enabled devices (e.g., kiosk mode devices don't need office)
			IF ((@office_version < @office_version_expected_int ) AND (@rdx_rac IS NOT NULL))
			  -- MSRETEL-270 (01.13.2017) - hardcoding 1611 here - too many demo devices are running office versions below 1611 to make 1611 the effective actual value
			  -- MSRETEL-300 (02.16.2017) - Office version rule expected value should show "1611 or newer"
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @office_version_actual_string, '1611 or newer', 0, @health_state, @health_state_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @office_version_actual_string, @hm_expected, 1, 'Running', @health_state_running_id
		  END
		  -- MSRETEL-309 (03.01.2017) - Account for office installs upgraded to recently released versions that are unknown to RED
		  ELSE
		      EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, NULL, @hm_expected, 1, 'Running', @health_state_running_id
		  
		END

		-- MSRETEL-315 (03.24.2017): Flag Canadian demo devices using en-us system locale
	    ELSE IF (@monitor_name = 'ENCALOCALE')
		BEGIN
		PRINT @en_ca_enabled
		PRINT @countryName
		    IF ( (@en_ca_enabled = 0 ) AND (@countryName = 'Canada'))
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, '-', @hm_expected, 0, @health_state, @health_state_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, '-', @hm_expected, 1, 'Running', @health_state_running_id
		END
		ELSE IF (@monitor_name = 'WIN10RS2')
		BEGIN
		    SET @os_build_number_int = CONVERT(INT, @hm_expected)
			SELECT @actual = (SELECT TOP 1 d.os_build_number FROM [dbo].[Device] d WHERE d.device_id = @device_id);
			--IF ((@actual >= @os_build_number_int ) OR (@exp_id = 18) OR (@exp_id = 13) OR (@device_model like '%Alienware X51%'))
			IF ((@actual >= @os_build_number_int ) OR (@exp_id = 18))
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 0, @health_state, @health_state_id
		END
		ELSE IF (@monitor_name = 'AdminWLAN')
		BEGIN
		    SELECT @actual = (SELECT TOP 1 d.wlan_ssid FROM [dbo].[Device] d WHERE d.device_id = @device_id);
			-- a null wlan_ssid implies a wired connection
			IF (lower(@actual) = 'seca')
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 0, 'Major', @health_state_major_id
			ELSE 
			  EXEC dbo.uspUpdateReportMonitorLevel @hm_id, @device_id, @store_number, @actual, @hm_expected, 1, 'Running', @health_state_running_id
		END

	FETCH NEXT FROM HealthMonitor_Cursor INTO
		@hm_id, @monitor_name, @title, @msg_fail, @health_state, @health_state_id, @hm_expected



	END

    CLOSE HealthMonitor_Cursor 
	DEALLOCATE HealthMonitor_Cursor

END