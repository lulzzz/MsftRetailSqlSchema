-- 06.26.2017 (MSRETEL-386): one year sliding window table updated by uspReloadRdxAppUsageStoreOverviewLast365Days (power bi data source)
-- 07.05.2017 (MSRETEL-392): fix fy 2018 week 1 bug (fy 2018 wk 1 data tagged as fy 2017 wk 52)


CREATE VIEW [dbo].[vwRdxAppUsageStoreOverviewLast365Days] AS
  	SELECT *,      
    [dbo].[ufnGetMSFiscalWeekNumberFromDate](EventDate) AS 'MSFiscalWeekNumber',
    [dbo].[ufnGetMSFiscalYearFromDate](EventDate) AS 'MSFiscalYear',
    [dbo].[ufnGetMSFiscalQuarterFromDate](EventDate) AS 'MSFiscalQuarter'
	FROM RdxAppUsageStoreOverviewLast365Days