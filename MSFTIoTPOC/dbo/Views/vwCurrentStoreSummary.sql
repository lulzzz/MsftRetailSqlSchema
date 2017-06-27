-- 09.02.2016 (MSRETEL-133): created this SQL view specfically for storesummary web api call

CREATE VIEW [vwCurrentStoreSummary] AS

SELECT 
    s.StoreNumber,
	hse.StoreDeviceCount,
	hse.StoreHealthPoints,
	hse.StoreHealthPercentage,
	hse.StoreHealthState,
	hse.StoreHealthStateId,
	e.display_name as 'ExperienceName',
	hse.ExperienceDeviceCount,
	hse.ExperienceHealthPoints,
	hse.ExperienceHealthPercentage,
	hse.ExperienceHealthState,
	hse.ExperienceHealthStateId,
	s.StoreName,
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
	s.MarketId,
	s.MarketRegionId
FROM
    vwCurrentHealthStateByStoreExperience hse,
	vwActiveStore s,
	Experience e
WHERE
    hse.StoreNumber = s.StoreNumber AND
	hse.ExperienceId = e.id