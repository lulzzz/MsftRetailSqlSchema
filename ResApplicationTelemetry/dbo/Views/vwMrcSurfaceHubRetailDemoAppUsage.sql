-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcSurfaceHubRetailDemoAppUsage] AS
SELECT 
    tbl1.EventTime, 
	tbl1.EventDate,
	tbl1.EventName, 
	tbl1.EventCount, 
	tbl1.DeviceType, 
	tbl1.SessionId, 
	tbl1.HubName, 
	tbl1.StoreNumber
FROM InputSurfaceHubEvents tbl1