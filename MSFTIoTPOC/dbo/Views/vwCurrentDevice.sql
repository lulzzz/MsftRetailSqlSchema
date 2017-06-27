-- MSRETEL-130 (09.01.2016): Create SQL view for "current" devices (devices within last 1 day)
-- MSRETEL-313 (03.16.2017): This view is for FoH demo devices only (e.g., community devices often offline & should not appear on dashboard map)

CREATE VIEW [vwCurrentDevice] AS
SELECT
	d.device_id as 'DeviceId',
	d.cs_name as 'DeviceName',
	d.modified_at as 'ModifiedAt',
	d.created_at as 'CreatedAt',
	e.display_name as 'ExperienceName',
	d.exp_id as 'ExperienceId',
	d.time_zone as 'TimeZone',
	d.rdx_rac as 'RdxRac',
	d.rdx_sku as 'RdxSku',
	d.health_state as 'DeviceHealthState',
	d.health_state_id as 'DeviceHealthStateId',
	d.health_points as 'DeviceHealthPoints',
	d.manufacturer as 'Manufacturer',
	d.model as 'Model',
	d.caption as 'OSCaption',
	d.os_build_number as 'OSBuildNumber',
	d.total_physical_memory as 'TotalPhysicalMemory',
	d.ip_address_v4 as 'IpAddressV4',
	d.external_ip as 'ExternalIpAddressV4',
	d.serial_number as 'SerialNumber',
	d.wlan_ssid as 'WlanSsid',
	d.exp_buildtool_version as 'UsbBuildToolVersion',
	d.store_number as 'StoreNumber'
FROM
	Device d,
	Experience e
WHERE
	d.exp_id = e.id AND
	d.demo_category = 1 AND -- 1 = FoH demo devices; 2 = community devices
	d.modified_at >= DATEADD(day, -1, GETDATE())