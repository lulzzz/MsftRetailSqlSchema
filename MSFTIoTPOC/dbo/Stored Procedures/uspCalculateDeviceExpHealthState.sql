-- MSRETEL-062 (08.17.2016): revised business rule - health monitor rules now apply to ALL demo experiences by default
-- MSRETEL-116 (09.01.2016): updated to support new health status id
-- MSRETEL-366 (05.19.2017): return health state id to support of daily device state history functionality

CREATE PROCEDURE dbo.uspCalculateDeviceExpHealthState
  @device_id INT, @exp_id INT
AS
BEGIN

	DECLARE @calculated_health_state VARCHAR(50)
	DECLARE @calculated_health_state_id INT
    DECLARE @monitor_health_state VARCHAR(50)
	DECLARE @calculated_health_points DECIMAL(2,1)

    -- default to 'Running' if no health monitor results found
    SET @calculated_health_state = 'Running'
	SET @calculated_health_points = 0

	-- find all *active* health monitor results for a demo device
	DECLARE HealthState_Cursor CURSOR FOR 
	SELECT hpml.health_state
	FROM 
	  [dbo].[HealthMonitorResult] hpml
	   JOIN [dbo].[HealthMonitor] hm ON hm.id = hpml.health_mon_id
	WHERE
	  device_id = @device_id and hm.active = 1
    ORDER BY hpml.health_state desc -- order by places 'Minor' and 'Major' at bottom of list
	
	--iterate health monitor results (last result on list trumps all other results - see "order by" above)
	OPEN HealthState_Cursor 
	FETCH NEXT FROM HealthState_Cursor INTO
		@monitor_health_state

	WHILE @@FETCH_STATUS = 0
	BEGIN

      SET @calculated_health_state = @monitor_health_state
	
	FETCH NEXT FROM HealthState_Cursor INTO
		@monitor_health_state


	END

    CLOSE HealthState_Cursor
    DEALLOCATE HealthState_Cursor

	IF (@calculated_health_state = 'Major')
	  SET @calculated_health_points = 1;
	IF (@calculated_health_state = 'Minor')
	  SET @calculated_health_points = .5;

	-- MSRETEL-116 (09.01.2016): retrieve health monitor id
	SET @calculated_health_state_id = (SELECT id from HealthState where name = @calculated_health_state);

	Update Device Set health_state = @calculated_health_state, health_state_id = @calculated_health_state_id, health_points = @calculated_health_points where device_id = @device_id

	-- MSRETEL-366 (05.19.2017) - return health state id (for daily device history state)
	return @calculated_health_state_id

END