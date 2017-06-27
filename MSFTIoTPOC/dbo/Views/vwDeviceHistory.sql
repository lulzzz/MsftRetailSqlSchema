-- MSRETEL-366 (05.19.2017): daily device history
-- MSRETEL-366 (05.24.2017): add device_id & exp_id
-- MSRETEL-385 (06.26.2017): add os_install_date

CREATE VIEW [vwDeviceHistory] AS
SELECT
    --COUNT(tbl1.serial_number) as 'DeviceCount',
	tbl1.device_id as 'DeviceID',
	tbl1.exp_id as 'ExpID',
	--tbl2.display_name as 'ExpName',
	tbl1.event_date as 'EventDate', 
	tbl1.health_state_id as 'HealthStateID',
	tbl1.store_number as 'StoreNumber',
	tbl1.os_build_number as 'OSBuildNumber',
	CONVERT(date, (LEFT (tbl1.os_install_date, 8))) as 'OSInstallDate'
FROM DeviceHistory tbl1, Experience tbl2
WHERE
  tbl1.exp_id = tbl2.id AND
  tbl1.event_date >= DATEADD(DAY, -60, GETDATE()) and 
  CONVERT(date, (LEFT (tbl1.os_install_date, 8))) >= DATEADD(DAY, -90, GETDATE()) and
  tbl1.device_id is not null