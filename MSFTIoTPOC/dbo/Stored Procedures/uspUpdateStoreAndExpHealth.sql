-- MSRETEL-314 (03.16.2017): This usp is now deprecated and can be removed

CREATE PROCEDURE dbo.uspUpdateStoreAndExpHealth
	@store_number int,
	@experience_id int
AS
BEGIN

	DECLARE @total_devices INT, @total_health_points decimal(5,1), @calculated_health_percent decimal(3,0), @calculated_health VARCHAR(50)

        --Update experience health
	SET @total_devices = (select count(device_id) as 'total_devices' from Device where store_number = @store_number and exp_id = @experience_id and modified_at >= DATEADD(day, -1, GETDATE()))
        SET @total_health_points = (select sum(health_points) as 'total_points' from Device where store_number = @store_number and exp_id = @experience_id and modified_at >= DATEADD(day, -1, GETDATE()))

        SET @calculated_health_percent = ((@total_health_points/@total_devices) * 100)

	--IF (@calculated_health_percent >= 80)
	IF (@calculated_health_percent > 25)
	--IF (@calculated_health_percent > 25 AND @total_devices > 1)
	  SET @calculated_health = 'Major'
	ELSE IF (@calculated_health_percent <= 25 AND @calculated_health_percent > 5)
	--ELSE IF (@calculated_health_percent <= 50 AND @calculated_health_percent > 0)
	--ELSE IF (@calculated_health_percent <= 80 AND @calculated_health_percent > 50)
	  SET @calculated_health = 'Minor'
	ELSE
	  SET @calculated_health = 'Running'

	UPDATE dbo.ExperienceHealth SET total_points = @total_health_points, total_devices = @total_devices, health_state = @calculated_health, modified_at = GETDATE()
          WHERE exp_id = @experience_id AND store_number = @store_number
        IF @@ROWCOUNT=0
          INSERT INTO dbo.ExperienceHealth (store_number, exp_id, total_devices, total_points, health_state, modified_at) 
            VALUES (@store_number, @experience_id, @total_devices, @total_health_points, @calculated_health, GETDATE()); 

        --Update store health
	SET @total_devices = (select count(device_id) as 'total_devices' from Device where store_number = @store_number and modified_at >= DATEADD(day, -1, GETDATE()))
        SET @total_health_points = (select sum(health_points) as 'total_points' from Device where store_number = @store_number and modified_at >= DATEADD(day, -1, GETDATE()))

        SET @calculated_health_percent = ((@total_health_points/@total_devices) * 100)

	--IF (@calculated_health_percent >= 80)
	--IF (@calculated_health_percent > 50)
	IF (@calculated_health_percent > 25)
	  SET @calculated_health = 'Major'
	--ELSE IF (@calculated_health_percent <= 80 AND @calculated_health_percent > 50)
	--ELSE IF (@calculated_health_percent <= 50 AND @calculated_health_percent > 0)
	ELSE IF (@calculated_health_percent <= 25 AND @calculated_health_percent > 5)
	  SET @calculated_health = 'Minor'
	ELSE
	  SET @calculated_health = 'Running'

	UPDATE dbo.StoreHealth SET total_points = @total_health_points, total_devices = @total_devices, health_state = @calculated_health, modified_at = GETDATE()
          WHERE store_number = @store_number
        IF @@ROWCOUNT=0
          INSERT INTO dbo.StoreHealth (store_number, total_devices, total_points, health_state, modified_at) 
            VALUES (@store_number, @total_devices, @total_health_points, @calculated_health, GETDATE()); 

END