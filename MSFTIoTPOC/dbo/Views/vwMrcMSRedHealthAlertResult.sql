-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [vwMrcMSRedHealthAlertResult] AS
SELECT 
    --hmr.id as 'ID',
    hm.id as 'HealthAlertID',
	hmr.device_id as 'DeviceID',
	hmr.health_state as 'HealthState',
	--hmr.store_number as 'StoreNumber',
	d.store_number as 'StoreNumber',
	hmr.passed as 'Result',
	hmr.date_passed as 'DatePassed',
	hmr.created_at 'FirstRunDate',
	hmr.modified_at 'LastRunDate'
FROM 
    HealthMonitorResult hmr, 
	HealthMonitor hm,
	Device d
WHERE 
    hmr.health_mon_id = hm.id AND 
	hmr.device_id = d.device_id AND
	hm.deleted = 0 AND hm.active = 1 AND
	d.store_number IS NOT NULL AND
	hmr.modified_at >= DATEADD(day, -28, GETDATE())