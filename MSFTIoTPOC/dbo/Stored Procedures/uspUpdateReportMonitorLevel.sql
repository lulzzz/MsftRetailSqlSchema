-- MSRETEL-062 (08.17.2016): revised business rule - health monitor rules now apply to ALL demo experiences by default
-- MSRETEL-116 (09.01.2016): updated to support new health status id
-- MSRETEL-138 (09.07.2016): localize health monitor *expected* results
-- MSRETEL-062 (09.15.2016): account for duplicate device health monitor result production data
-- MSRETEL-156 (09.21.2016): revise solution for duplicate health monitor result production data issue

CREATE PROCEDURE dbo.uspUpdateReportMonitorLevel
	@health_mon_id int,
    @device_id int,
	@store_number int,
	@actual varchar(50),
	@expected varchar(50),
    @test_result int,
    @health_state varchar(50),
	@health_state_id INT
AS
BEGIN

	DECLARE @previous_result INT, @today_time DATETIME, @health_mon_result_id INT

	SET @today_time = getdate()

	-- MSRETEL-062 (08.17.2016): lookup previous health monitor result for this device
	-- MSRETEL-062 (09.15.2016): account for duplicate device health monitor result data in production (duplicate data result of a bug)
	-- MSRETEL-156 (09.21.2016): grab the most recent health monitor result for this device (i.e., older duplicate results should be ignored)
	SELECT top 1 @health_mon_result_id = hmr.id, @previous_result = hmr.passed
	FROM 
		[dbo].[HealthMonitorResult] hmr, 
		[dbo].[HealthMonitor] hm
	WHERE 
	    hmr.health_mon_id = hm.id AND
		hmr.device_id = @device_id AND
		hm.id = @health_mon_id 
	ORDER BY hmr.id DESC -- grab the most recent result, if there are multiple/duplicate health monitor results for a device

	IF @previous_result IS NULL
	  BEGIN
		IF (@test_result = 1)
		  INSERT INTO [dbo].[HealthMonitorResult](health_mon_id, device_id, store_number, actual, expected, health_state, health_state_id, passed, date_passed, created_at, modified_at) VALUES (@health_mon_id, @device_id, @store_number, @actual, @expected, @health_state, @health_state_id, @test_result, @today_time, @today_time, @today_time)
		Else
		  INSERT INTO [dbo].[HealthMonitorResult](health_mon_id, device_id, store_number, actual, expected, health_state, health_state_id, passed, created_at, modified_at) VALUES (@health_mon_id, @device_id, @store_number, @actual, @expected, @health_state, @health_state_id, @test_result, @today_time, @today_time)
	  END
	ELSE
	  BEGIN
	  -- if the monitor result was the same as the last time, then only update the time the monitor result was last checked, store number, health state (example: decide to hange health monitor from 'Minor' to 'Major'), and actual (example: wlan ssid may change from MicrosoftStore to SECA)
	  --061116 - Added health_state and actual for SECA health rule exception - SECA is Major, all other non-DemoNet wlan ssids are Minor)
	  IF (@test_result = @previous_result) 
		UPDATE [dbo].[HealthMonitorResult] SET health_mon_id = @health_mon_id, store_number = @store_number, modified_at = @today_time, health_state = @health_state, health_state_id = @health_state_id, actual = @actual, expected = @expected WHERE id = @health_mon_result_id
	  ELSE
		BEGIN
		  -- if there was a change in the test result from last check, seet the date_passed field to null if device is no longer passing
		  IF (@test_result = 1)
			UPDATE [dbo].[HealthMonitorResult] SET health_mon_id = @health_mon_id, store_number = @store_number, health_state = @health_state, health_state_id = @health_state_id, actual = @actual, expected = @expected, passed = @test_result, date_passed = @today_time, modified_at = @today_time WHERE id = @health_mon_result_id
		  ELSE
			UPDATE [dbo].[HealthMonitorResult] SET health_mon_id = @health_mon_id, store_number = @store_number, health_state = @health_state, health_state_id = @health_state_id, actual = @actual, expected = @expected, passed = @test_result, date_passed = null, modified_at = @today_time WHERE id = @health_mon_result_id
		END
	  END

END