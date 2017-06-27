-- 09.01.2016 (MSRETEL-130): Create health monitor results SQL view using "current" devices and "active" health monitors
-- 09.07.2016 (MSRETEL-138): Localize health monitor *expected* results; Improve SQL view columm names
-- 09.09.2016 (MSRETEL-139): Exclude unassigned store devices (ie., store number is null)
-- 05.30.2017 (MSRETEL-368): Add experience name (to be used by MS RED Overview Power BI report)

CREATE VIEW [vwCurrentHealthMonitorResult] AS
SELECT 
    hm.id as 'MonitorId',
    hm.name as 'MonitorShortName',
	hm.title as 'MonitorLongName', 
	hm.message_fail as 'MonitorFailureMessage',
	hm.active as 'MonitorActive',
	hmr.health_state_id as 'ResultHealthStateId',
	hmr.health_state as 'ResultHealthState',
    hmr.actual as 'ResultActual', 
	hmr.expected as 'ResultExpected',
	hmr.device_id as 'ResultDeviceId',
	d.ExperienceName as 'ResultExperienceName',
	hmr.store_number as 'ResultStoreNumber',
	hmr.passed as 'ResultStatus', 
	hmr.date_passed as 'ResultPassed',
	hmr.created_at 'ResultFirstRecorded',
	hmr.modified_at 'ResultLastUpdated'
FROM 
    HealthMonitorResult hmr, 
	HealthMonitor hm,
	vwCurrentDevice d
WHERE 
    hmr.health_mon_id = hm.id AND 
	hmr.device_id = d.DeviceId AND
	hm.deleted = 0 AND hm.active = 1 AND
	hmr.store_number IS NOT NULL