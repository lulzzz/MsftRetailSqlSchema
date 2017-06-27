CREATE PROCEDURE dbo.[uspProcessIncomingGrooveTelemetry]
AS
BEGIN

DECLARE @groove_incoming_id INT, @event_time DATETIME, @event_name VARCHAR(50), @event_count INT
DECLARE @view_name VARCHAR(50), @view_count INT, @duration_value FLOAT, @session_id VARCHAR(100)
DECLARE @duration_count FLOAT, @device_type VARCHAR(50), @client_ip VARCHAR(50), @continent VARCHAR(50)
DECLARE @country VARCHAR(50), @province VARCHAR(50), @city VARCHAR(50), @store_number INT, @calc_event_dur FLOAT

DECLARE GrooveMessage_Cursor CURSOR FOR 
	SELECT id, event_time, event_name, event_count, view_name, view_count, duration_value, duration_count, device_type, client_ip, continent, country, province, city, session_id FROM InputGrooveTelemetry WHERE processed = 0

OPEN GrooveMessage_Cursor 

FETCH NEXT FROM GrooveMessage_Cursor INTO
    @groove_incoming_id, @event_time, @event_name, @event_count, @view_name, @view_count, @duration_value, @duration_count, @device_type, @client_ip, 
	@continent, @country, @province, @city, @session_id

	WHILE @@FETCH_STATUS = 0
	BEGIN
    
		--attempt to get the store number
		SET @store_number = [dbo].[ufnGetStoreNumberByNetworkId](@client_ip)

		IF (@event_name IS NOT NULL)
		BEGIN
			UPDATE dbo.GrooveTelemetryReportUserEvent SET event_count = event_count + 1, modified_at = getdate()  WHERE store_number = @store_number AND event_name = @event_name AND event_date = CONVERT(date, getdate())

			IF @@ROWCOUNT=0
				INSERT INTO dbo.GrooveTelemetryReportUserEvent (created_at, modified_at, event_date, event_name, event_count, store_number) VALUES (GETDATE(), GETDATE(), CONVERT(date, getdate()), @event_name, @event_count, @store_number)
		END

		-- "durations are represented in tenths of a microsecond, so that 10000000.0 means 1 second" (source: 'Application Insights Export Data Model')
		IF (@duration_value IS NOT NULL)
		  SET @calc_event_dur = ROUND(((@duration_value / 10000000) / 60),1)

		--calculate time that Music Experience demo app was idle
		IF (@view_name = 'Dashboard' AND (@calc_event_dur IS NOT NULL))
		  INSERT INTO dbo.GrooveTelemetryReportUserActivity (created_at, modified_at, event_time, event_date, event_name, event_duration_mins, session_id, store_number) VALUES (GETDATE(), GETDATE(), @event_time, CONVERT(date, @event_time), 'idle', @calc_event_dur, @session_id, @store_number)

	    --calculate time that user was interacting with Music Experience demo app
		IF (@view_name = 'MainPage' AND (@calc_event_dur IS NOT NULL))
		    INSERT INTO dbo.GrooveTelemetryReportUserActivity (created_at, modified_at, event_time, event_date, event_name, event_duration_mins, session_id, store_number) VALUES (GETDATE(), GETDATE(), @event_time, CONVERT(date, @event_time), 'active', @calc_event_dur, @session_id, @store_number)

		--assign this telemetry a store
		UPDATE dbo.InputGrooveTelemetry SET store_number = @store_number WHERE id = @groove_incoming_id;

		--mark this telemetry as processed!
		UPDATE dbo.InputGrooveTelemetry SET processed = 1 WHERE id = @groove_incoming_id;

		FETCH NEXT FROM GrooveMessage_Cursor INTO
		@groove_incoming_id, @event_time, @event_name, @event_count, @view_name, @view_count, @duration_value, @duration_count, @device_type, @client_ip, 
		@continent, @country, @province, @city, @session_id


	END

	CLOSE GrooveMessage_Cursor 
	DEALLOCATE GrooveMessage_Cursor

END