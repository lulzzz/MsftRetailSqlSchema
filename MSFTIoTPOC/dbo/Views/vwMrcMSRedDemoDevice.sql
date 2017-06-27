-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcMSRedDemoDevice] AS
SELECT
	tbl1.device_id as 'ID',
	tbl1.modified_at as 'ModifiedDate',
	tbl1.created_at as 'CreatedDate',
	tbl1.cs_name as 'Name',
	tbl1.health_state as 'HealthState',
	tbl1.demo_category as 'CustomerID',
	tbl1.caption as 'OSCaption',
	tbl1.os_build_number as 'OSBuildNumber',
	tbl1.manufacturer as 'Manufacturer',
	tbl1.model as 'Model',
	tbl1.total_physical_memory as 'TotalPhysicalMemory',
	tbl1.ip_address_v4 as 'IpAddressV4',
	tbl1.serial_number as 'BiosSerialNumber',
	tbl1.store_number as 'StoreNumber',
	tbl1.rdx_rac as 'RdxRac',
	tbl1.rdx_sku as 'RdxSku',
	tbl1.exp_buildtool_version as 'BuildToolVersion',
    tbl1.exp_name as 'ExperienceName',
    tbl1.wlan_ssid as 'WlanSsid',
	tbl1.time_zone as 'TimeZone'
FROM
	Device tbl1
WHERE
    tbl1.modified_at >= DATEADD(day, -28, GETDATE())