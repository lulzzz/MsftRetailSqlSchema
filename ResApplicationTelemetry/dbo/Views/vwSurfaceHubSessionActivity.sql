CREATE VIEW [dbo].[vwSurfaceHubSessionActivity] AS
SELECT 
    tbl1.EventTime, tbl1.EventDate,
	[dbo].[ufnGetWeekDateFromDate](EventDate) AS 'EventWeekDate',
	[dbo].[ufnGetQuarterNumberFromDate](EventDate) AS 'EventQuarter',
	[dbo].[ufnGetWeekNumberFromDate](EventDate) AS 'EventWeekNumber',
    [dbo].[ufnGetMSFiscalWeekNumberFromDate](EventDate) AS 'MSFiscalWeekNumber',
    [dbo].[ufnGetMSFiscalYearFromDate](EventDate) AS 'MSFiscalYear',
    [dbo].[ufnGetMSFiscalQuarterFromDate](EventDate) AS 'MSFiscalQuarter',
	tbl1.EventName, tbl1.EventCount, 
	tbl1.DeviceType, tbl1.SessionId, tbl1.HubName, tbl1.StoreNumber
FROM InputSurfaceHubEvents tbl1