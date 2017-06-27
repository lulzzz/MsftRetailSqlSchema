-- 06.26.2017 (MSRETEL-386): one year sliding window table updated by uspReloadRdxAppUsageStoreOverviewLast365Days (power bi data source)

CREATE VIEW [dbo].[vwRdxAppUsageStoreOverviewLast365Days] AS
  	SELECT *,      
	CASE
          WHEN (EventWeekNumber - 27 < 1) THEN (53 + EventWeekNumber - 27)
		  ELSE (EventWeekNumber - 27)
        END AS 'MSFiscalWeekNumber',
		CASE
          WHEN (EventWeekNumber > 27) THEN YEAR(DATEADD(year,1,EventDate))
		  ELSE (YEAR(EventDate))
        END AS 'MSFiscalYear',
		CASE
          WHEN (EventQuarter = 1) THEN 3
		  WHEN (EventQuarter = 2) THEN 4
		  WHEN (EventQuarter = 3) THEN 1
		  WHEN (EventQuarter = 4) THEN 2
        END AS 'MSFiscalQuarter'

	FROM RdxAppUsageStoreOverviewLast365Days