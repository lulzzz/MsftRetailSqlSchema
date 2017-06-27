-- 09.02.2016 (MSRETEL-133): created this SQL view specfically for devicedetails web api call

CREATE VIEW [vwCurrentDeviceDetails] AS
SELECT
    s.StoreName,
	s.StoreNumber,
	s.StoreFlag,
	s.StoreCexAcronym,
	s.StoreRtgAcronym,
	s.CityName,
	s.CityLatitude,
	s.CityLongitude,
	s.StoreLatitude,
	s.StoreLongitude,
	s.RegionName,
	s.CountryName,
	d.DeviceId,
	d.DeviceName,
    d.CreatedAt,
	d.ModifiedAt,
	d.ExperienceName,
	d.ExperienceId,
	d.TimeZone,
	d.RdxRac,
	d.RdxSku,
	d.DeviceHealthState,
	d.DeviceHealthStateId,
	d.DeviceHealthPoints,
	d.Manufacturer,
	d.Model,
	d.OSCaption,
	d.OSBuildNumber,
	d.IpAddressV4,
	d.ExternalIpAddressV4,
	d.WlanSsid,
	d.SerialNumber,
	d.TotalPhysicalMemory,
	d.UsbBuildToolVersion
FROM
	vwCurrentDevice d,
	vwActiveStore s
WHERE
    d.StoreNumber = s.StoreNumber