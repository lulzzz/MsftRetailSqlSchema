CREATE VIEW [dbo].[vwAppsNowSessionActivity] AS
SELECT 
    tbl1.AsaSysTime,
	tbl1.SqlSysTime,
    tbl1.EventTime,
	tbl1.EventDate,
	--[dbo].[ufnGetWeekDateFromDate](EventDate) AS 'EventWeekDate',
	--[dbo].[ufnGetQuarterNumberFromDate](EventDate) AS 'EventQuarter',
	--[dbo].[ufnGetWeekNumberFromDate](EventDate) AS 'EventWeekNumber',
    --[dbo].[ufnGetMSFiscalWeekNumberFromDate](EventDate) AS 'MSFiscalWeekNumber',
    --[dbo].[ufnGetMSFiscalYearFromDate](EventDate) AS 'MSFiscalYear',
    --[dbo].[ufnGetMSFiscalQuarterFromDate](EventDate) AS 'MSFiscalQuarter',
	tbl1.EventName,
	tbl1.EventCount,
	tbl1.DeviceType,
	tbl1.DeviceOSVersion,
	tbl1.DeviceBrowser,
	tbl1.SessionId as 'SessionID',
	tbl1.UserAnonId as 'UserAnonID',
	tbl1.OperationId as 'OperationID',
	tbl1.ClientIp,
	tbl1.Continent,
	tbl1.Country,
	tbl1.Province,
	tbl1.City,
	NULL as 'AppName',
	tbl1.PlatformId as 'PlatformID',
	tbl1.PlatformName,
	tbl1.SearchCategories as 'Categories',
	tbl1.StoreNumber,
	tbl1.StoreName,
	NULL as 'Uri',
	0 as Processed
FROM
  InputRsitLoginAndSearch tbl1

UNION ALL

SELECT
    tbl1.AsaSysTime,
	tbl1.SqlSysTime,
    tbl1.EventTime,
	tbl1.EventDate,
	--[dbo].[ufnGetWeekDateFromDate](EventDate) AS 'EventWeekDate',
	--[dbo].[ufnGetQuarterNumberFromDate](EventDate) AS 'EventQuarter',
	--[dbo].[ufnGetWeekNumberFromDate](EventDate) AS 'EventWeekNumber',
    --[dbo].[ufnGetMSFiscalWeekNumberFromDate](EventDate) AS 'MSFiscalWeekNumber',
    --[dbo].[ufnGetMSFiscalYearFromDate](EventDate) AS 'MSFiscalYear',
    --[dbo].[ufnGetMSFiscalQuarterFromDate](EventDate) AS 'MSFiscalQuarter',
	tbl1.EventName,
	tbl1.EventCount,
	tbl1.DeviceType,
	tbl1.DeviceOSVersion,
	tbl1.DeviceBrowser,
	tbl1.SessionId as 'SessionID',
	tbl1.UserAnonId as 'UserAnonID',
	tbl1.OperationId as 'OperationID',
	tbl1.ClientIp,
	tbl1.Continent,
	tbl1.Country,
	tbl1.Province,
	tbl1.City,
	tbl1.AppName, -- unique to app install event
	tbl1.AppPlatformId as 'PlatformID',
	tbl1.AppPlatformName as 'PlatformName',
	tbl1.AppCategoryName as 'Categories',
	tbl1.StoreNumber,
	tbl1.AppStoreName as 'StoreName',
	NULL as 'Uri',
	0 as Processed

FROM
InputRsitAppInstall tbl1