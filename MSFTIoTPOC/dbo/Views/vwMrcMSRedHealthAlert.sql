-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcMSRedHealthAlert] AS

SELECT
    tbl1.id as 'ID',
	tbl1.title as 'Name'
FROM 
    HealthMonitor tbl1
WHERE 
    tbl1.active = 1 and deleted = 0