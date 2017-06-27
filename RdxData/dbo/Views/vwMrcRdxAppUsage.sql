-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcRdxAppUsage] AS
SELECT top 10
tbl1.DateAdded,
tbl1.EventDate,
tbl1.EventTime,
--[dbo].[ufnGetWeekDateFromDate](tbl1.EventDate) AS 'EventWeekDate',
--[dbo].[ufnGetQuarterNumberFromDate](tbl1.EventDate) AS 'EventQuarter',
--[dbo].[ufnGetWeekNumberFromDate](tbl1.EventDate) AS 'EventWeekNumber',
--[dbo].[ufnGetMSFiscalWeekNumberFromDate](tbl1.EventDate) AS 'MSFiscalWeekNumber',
--[dbo].[ufnGetMSFiscalYearFromDate](tbl1.EventDate) AS 'MSFiscalYear',
--[dbo].[ufnGetMSFiscalQuarterFromDate](tbl1.EventDate) AS 'MSFiscalQuarter',
tbl1.DeviceId as 'DeviceID',
tbl1.AppId as 'AppID',
tbl1.AppName,
tbl1.AppTitle,
tbl1.AppVersion,
tbl1.AppType,
tbl1.Category,
tbl1.UserActiveDurationS,
tbl1.InteractivityDurationS,
tbl1.KeyboardInputSecCount,
tbl1.MouseInputSecCount,
tbl1.TouchInputSecCount,
tbl1.PenInputSecCount,
tbl1.LaunchCount,
tbl1.SessionId as 'SessionID'
FROM RdxAppUsage tbl1
WHERE
  tbl1.EventDate >= DATEADD(day,-6,getdate())