-- 09.01.2016 (MSRETEL-130): Create SQL view for all "active" stores (all current & NSO stores)
-- 09.01.2016 (MSRETEL-118): Add store latitude/longitude coordinates 
-- 09.27.2016 (MSRETEL-073): Add store type id column in support of "inline store" changes

CREATE VIEW [vwActiveStore] AS
SELECT 
  s.Number as 'StoreNumber',
  s.Name as 'StoreName',
  st.Flag as 'StoreFlag',
  s.CexAcronym as 'StoreCexAcronym',
  s.RtgAcronym as 'StoreRtgAcronym',
  s.ServerName as 'StoreServerName',
  s.TimeZone as 'StoreTimeZone',
  s.Latitude as 'StoreLatitude',
  s.Longitude as 'StoreLongitude',
  ci.Latitude as 'CityLatitude',
  ci.Longtitude as 'CityLongitude',
  ci.Name as 'CityName',
  r.Name as 'RegionName',
  co.Name as 'CountryName',
  m.MarketId as 'MarketId',
  m.Name as 'MarketName',
  m.Longitude as 'MarketLongitude',
  m.Latitude as 'MarketLatitude',
  m.ScaleFactor as 'MarketScaleFactor',
  mr.MarketRegionId as 'MarketRegionId',
  mr.Name as 'MarketRegionName',
  mr.Longitude as 'MarketRegionLongitude',
  mr.Latitude as 'MarketRegionLatitude',
  mr.ScaleFactor as 'MarketRegionScaleFactor'
FROM
  Stores s,
  StoreTypes st,
  Cities ci,
  Regions r,
  Countries co,
  Markets m,
  MarketRegions mr
WHERE
  s.StoreTypeId = st.StoreTypeId AND
  s.CityId = ci.CityId AND
  ci.RegionId = r.RegionId AND
  r.CountryId = co.CountryId AND
  s.MarketId = m.MarketId AND
  m.MarketRegionId = mr.MarketRegionId AND
  s.Deleted = 0