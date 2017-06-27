-- 06.26.2017 (MSRETEL-386): reload rdx app usage store overview data using azure automation

CREATE PROCEDURE [dbo].[uspReloadRdxAppUsageStoreOverviewLast365Days]
AS
BEGIN
	
  DECLARE @NumberRecordsProcessed INT
  SET @NumberRecordsProcessed = 0
	
  BEGIN TRANSACTION
  BEGIN TRY

    -- recalculate store overview stats based on current rdx app usage data
    TRUNCATE TABLE RdxAppUsageStoreOverviewLast365Days
	INSERT INTO RdxAppUsageStoreOverviewLast365Days(EventDate, EventWeekDate, EventWeekNumber, EventQuarter,
	TotalUserActiveDurationS, TotalAppsLaunchCount, TotalSessionCount, TotalDeviceCount, AverageSessionDurationS, 
	StoreNumber, Rac)
	SELECT 
	  tbl1.EventDate,
	  (DATEADD(wk, DATEDIFF(wk,0,EventDate), -1)),
	  (DATEPART(WEEK,EventDate)),
	  (DATEPART(QUARTER, EventDate)),
	  SUM(tbl1.UserActiveDurationS) AS 'TotalUserActiveDurationS', 
	  SUM(tbl1.LaunchCount) AS 'TotalAppsLaunchCount', 
	  COUNT (DISTINCT tbl1.SessionId) AS 'TotalSessionCount', 
	  COUNT (DISTINCT tbl1.DeviceId) AS 'TotalDeviceCount', 
	  (SUM(tbl1.UserActiveDurationS) / COUNT (DISTINCT tbl1.SessionId)) AS 'AverageSessionDurationS',
	  tbl2.StoreNumber, 
	  tbl2.RAC
	  --CONCAT(tbl2.StoreNumber, '_', tbl1.EventDate) as 'StoreEventDateId'
	FROM 
	  RdxAppUsage tbl1
	  left outer join RdxDevices tbl2 ON tbl2.DeviceId = tbl1.DeviceId
	  --left outer join FriendlyExpName tbl3 ON UPPER(tbl2.RAC) = UPPER(tbl3.RAC)
	WHERE tbl2.MDC1DeviceFamily = 'PC' and EventDate >= DATEADD(day,-366,GETDATE()) -- account for leap year
	GROUP BY 
	  tbl1.EventDate, tbl2.StoreNumber, tbl2.RAC

	SET @NumberRecordsProcessed = @@ROWCOUNT

	COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH

  RETURN @NumberRecordsProcessed

END