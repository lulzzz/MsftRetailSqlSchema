-- 04.25.2017 (MSRETEL-386): process recent rdx application usage into rolling 30 day table using azure automation
-- 05.05.2017 (MSRETEL-386): cleanup rdx device data (store assignment, oem names) using uspProcessRdxDevices
-- 06.26.2017 (MSRETEL-386): adjust app usage groom config from 30 to 35 days 

CREATE PROCEDURE [dbo].[uspUpdateRdxAppUsageLast30Days]
AS
BEGIN
	
  DECLARE @NumberRecordsToProcess INT, @NumberRecordsProcessed INT
  SET @NumberRecordsProcessed = 0
	
  BEGIN TRANSACTION
  BEGIN TRY

    -- 05.05.2017 (MSRETEL-386): store assignment & oem cleanup for recently built rdx devices
	EXEC uspProcessRdxDevices

  	--check for recent rdx app usage data
    SELECT @NumberRecordsToProcess = (select count(Id) from RdxAppUsage where Processed = 0);
    PRINT @NumberRecordsToProcess

    IF (@NumberRecordsToProcess > 0) 
	BEGIN

	  --move recent usage data into 30 day rolling window table
	  INSERT INTO RdxAppUsageLast30Days(EventDate, EventTime, EventWeekDate, EventWeek, DeviceId, SessionId, AppName, AppTitle, AppVersion, AppType, Category, UserActiveDurationS, LaunchCount) 
	  SELECT EventDate,EventTime,(DATEADD(wk, DATEDIFF(wk,0,EventDate), -1)),(DATEPART(WEEK,EventDate)), DeviceId, SessionId, AppName, AppTitle, AppVersion, AppType, Category, UserActiveDurationS, LaunchCount
	  FROM RdxAppUsage WHERE Processed = 0

	  --mark recent usage data as processed
	  SET @NumberRecordsProcessed = @@ROWCOUNT
	  IF (@NumberRecordsProcessed > 0)
	    UPDATE RdxAppUsage SET Processed = 1 WHERE Processed = 0
 
      --delete old usage data
      DELETE FROM RdxAppUsageLast30Days WHERE EventWeekDate < DATEADD(day, -35, GETDATE())

	END

	COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH

  RETURN @NumberRecordsProcessed

END