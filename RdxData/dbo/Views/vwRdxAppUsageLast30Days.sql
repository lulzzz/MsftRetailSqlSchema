-- 06.26.2017 (MSRETEL-386): four week sliding window table updated by uspUpdateRdxAppUsageLast30Days (power bi data source)

CREATE VIEW [dbo].[vwRdxAppUsageLast30Days] AS
SELECT 
tbl3.StoreNumber,
tbl1.EventDate,
tbl1.EventWeekDate,
tbl1.EventWeek,
tbl1.DeviceId,
tbl3.DeviceName as 'DeviceName',
tbl3.FirstOnlineDate as 'DeviceFirstOnlineDate',
tbl3.MDC1DeviceFamily as 'DeviceFamily',
tbl3.RAC as 'RdxRac',
tbl4.ID as 'FriendlyExpNameID',
tbl3.OEMName,
tbl3.OEMModel,
tbl1.Category,
tbl1.SessionId,
tbl2.ID as 'FriendlyAppNameID',
tbl1.AppTitle,
tbl1.AppType,
tbl1.AppName,
tbl1.AppVersion,
tbl1.UserActiveDurationS,
tbl1.LaunchCount
--CONCAT(tbl3.StoreNumber, '_', tbl1.EventDate) as 'StoreEventDateId'
FROM RdxAppUsageLast30Days tbl1
left outer join FriendlyAppName tbl2 ON tbl2.AppTitle = tbl1.AppTitle
left outer join RdxDevices tbl3 ON tbl3.DeviceId = tbl1.DeviceId
left outer join FriendlyExpName tbl4 ON UPPER(tbl3.RAC) = UPPER(tbl4.RAC)
WHERE tbl3.MDC1DeviceFamily = 'PC' and tbl3.StoreNumber IS NOT NULL