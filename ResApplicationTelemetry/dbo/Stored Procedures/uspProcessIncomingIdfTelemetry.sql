--MSRETEL-298 (02.10.2017): Migrated IDF telemetry processing from cloud service to asa job
--MSRETEL-298 (02.16.2017): Convert duration strings to integers (seconds)

CREATE PROCEDURE dbo.[uspProcessIncomingIdfTelemetry]
AS
BEGIN

DECLARE @asa_output_id INT, @event_date DATE, @exp_name VARCHAR(200), @client_ip VARCHAR(50)
DECLARE @country VARCHAR(50), @store_number INT, @store_name VARCHAR(200)
DECLARE @store_lat VARCHAR(100), @store_lon VARCHAR(100), @store_city VARCHAR(100), @store_region VARCHAR(100)
DECLARE @page_view_duration VARCHAR(50), @video_play_duration VARCHAR(50)
DECLARE @page_view_duration_secs INT, @video_play_duration_secs INT

DECLARE AsaOutput_Cursor CURSOR FOR 
	SELECT Id, EventDate, ExperienceName, ClientIp, Country, PageViewDuration, VideoPlayDuration
	FROM InputIdfTelemetry WHERE Processed = 0

OPEN AsaOutput_Cursor 

FETCH NEXT FROM AsaOutput_Cursor INTO
    @asa_output_id, @event_date, @exp_name, @client_ip, @country, @page_view_duration, @video_play_duration

	WHILE @@FETCH_STATUS = 0
	BEGIN
    
		--attempt to get the store number
		SET @store_number = [dbo].[ufnGetStoreNumberByNetworkId](@client_ip)

		IF (@store_number IS NOT NULL)
		BEGIN

			SET @store_name = (SELECT Name from Stores where Number = @store_number)
			SET @store_lat = (SELECT Latitude from Stores where Number = @store_number)
			SET @store_lon = (SELECT Longitude from Stores where Number = @store_number)
			SET @store_city = (select c.Name as 'City' from Stores s, Cities c where s.CityId = c.CityId and s.Number = @store_number)
			SET @store_region = (select r.Name as 'Region' from Stores s, Cities c, Regions r where s.CityId = c.CityId and c.RegionId = r.RegionId and s.Number = @store_number)

			UPDATE MapData SET [Views] = [Views] + 1 WHERE StoreNumber = @store_number and ExperienceName=@exp_name and EventDate = @event_date
			IF @@ROWCOUNT=0
		        INSERT INTO MapData (ExperienceName, City, StoreName, StoreNumber, EventDate, [Views], Latitude, Longitude, Country, Region) 
				VALUES (@exp_name, @store_city, @store_name, @store_number, @event_date, 1, @store_lat, @store_lon, @country, @store_region)

		END

		SET @page_view_duration_secs = [dbo].[ufnGetIdfDurationInSeconds](@page_view_duration)
		SET @video_play_duration_secs = [dbo].[ufnGetIdfDurationInSeconds](@video_play_duration)
		
		--assign this telemetry a store and mark record as processed
		UPDATE dbo.InputIdfTelemetry 
		SET StoreNumber = @store_number, VideoPlayDurationSecs = @video_play_duration_secs, PageViewDurationSecs = @page_view_duration_secs, Processed = 1
		WHERE Id = @asa_output_id;


		FETCH NEXT FROM AsaOutput_Cursor INTO
        @asa_output_id, @event_date, @exp_name, @client_ip, @country, @page_view_duration, @video_play_duration

	END

	CLOSE AsaOutput_Cursor 
	DEALLOCATE AsaOutput_Cursor

END