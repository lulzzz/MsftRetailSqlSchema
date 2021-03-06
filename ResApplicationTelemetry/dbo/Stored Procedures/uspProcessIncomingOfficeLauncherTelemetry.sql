﻿CREATE PROCEDURE dbo.[uspProcessIncomingOfficeLauncherTelemetry]
AS
BEGIN

DECLARE @asa_output_id INT, @event_time DATETIME, @event_name VARCHAR(50), @event_count INT
DECLARE @view_name VARCHAR(50), @view_count INT, @duration_value FLOAT
DECLARE @duration_count FLOAT, @device_type VARCHAR(50), @client_ip VARCHAR(50), @continent VARCHAR(50)
DECLARE @country VARCHAR(50), @province VARCHAR(50), @city VARCHAR(50), @store_number INT, @calc_event_dur FLOAT

DECLARE AsaOutput_Cursor CURSOR FOR 
    --SELECT device_message_id, created_at, caption, cs_name, manufacturer, model, total_physical_memory, ip_address_v4, serial_number, exp_name, exp_buildtool_version, exp_app_installed, exp_attract_loop, exp_bluetooth, exp_config, exp_content, exp_msa,exp_patch_level, exp_rdx_enabled, exp_version, exp_video FROM DeviceMessage WHERE processed = 0
	SELECT Id, EventTime, EventName, EventCount, ViewName, ViewCount, DurationValue, DurationCount, DeviceType, ClientIp, Continent, Country, Province, City FROM InputOfficeLauncherTelemetry WHERE Processed = 0

OPEN AsaOutput_Cursor 

FETCH NEXT FROM AsaOutput_Cursor INTO
    @asa_output_id, @event_time, @event_name, @event_count, @view_name, @view_count, @duration_value, @duration_count, @device_type, @client_ip, 
	@continent, @country, @province, @city

	WHILE @@FETCH_STATUS = 0
	BEGIN
    
		--attempt to get the store number
		SET @store_number = [dbo].[ufnGetStoreNumberByNetworkId](@client_ip)

		--record a failed store assignment
		--IF (@store_number IS NULL)
		--    UPDATE GrooveTelemetryDebug SET client_ip = @client_ip

		--IF (@event_name IS NOT NULL)
		--BEGIN
			--UPDATE dbo.GrooveTelemetryReportUserEvent SET event_count = event_count + 1, modified_at = getdate()  WHERE store_number = @store_number AND event_name = @event_name AND event_date = CONVERT(date, getdate())

			--IF @@ROWCOUNT=0
				--INSERT INTO dbo.GrooveTelemetryReportUserEvent (created_at, modified_at, event_date, event_name, event_count, store_number) VALUES (GETDATE(), GETDATE(), CONVERT(date, getdate()), @event_name, @event_count, @store_number)
		--END

		-- "durations are represented in tenths of a microsecond, so that 10000000.0 means 1 second" (source: 'Application Insights Export Data Model')
		--IF (@duration_value IS NOT NULL)
		--  SET @calc_event_dur = ROUND(((@duration_value / 10000000) / 60),1)

		--calculate time that Music Experience demo app was idle
		--IF (@view_name = 'Dashboard' AND (@calc_event_dur IS NOT NULL))
		--  INSERT INTO dbo.GrooveTelemetryReportUserActivity (created_at, modified_at, event_time, event_date, event_name, event_duration_mins, store_number) VALUES (GETDATE(), GETDATE(), @event_time, CONVERT(date, @event_time), 'idle', @calc_event_dur, @store_number)

	    --calculate time that user was interacting with Music Experience demo app
		--IF (@view_name = 'MainPage' AND (@calc_event_dur IS NOT NULL))
		--    INSERT INTO dbo.GrooveTelemetryReportUserActivity (created_at, modified_at, event_time, event_date, event_name, event_duration_mins, store_number) VALUES (GETDATE(), GETDATE(), @event_time, CONVERT(date, @event_time), 'active', @calc_event_dur, @store_number)

		--assign this telemetry a store
		UPDATE dbo.InputOfficeLauncherTelemetry SET StoreNumber = @store_number WHERE Id = @asa_output_id;

		--mark this telemetry as processed!
		UPDATE dbo.InputOfficeLauncherTelemetry SET Processed = 1 WHERE Id = @asa_output_id;

		FETCH NEXT FROM AsaOutput_Cursor INTO
		@asa_output_id, @event_time, @event_name, @event_count, @view_name, @view_count, @duration_value, @duration_count, @device_type, @client_ip, 
		@continent, @country, @province, @city
		--@exp_app_installed, @exp_attract_loop, @exp_bluetooth, @exp_config, @exp_content, @exp_msa, 
		--@exp_patch_level, @exp_rdx_enabled, @exp_version, @exp_video

	END

	CLOSE AsaOutput_Cursor 
	DEALLOCATE AsaOutput_Cursor

END