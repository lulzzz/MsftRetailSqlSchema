-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [vwMrcMSRetailStore] AS
SELECT 
  s.Number as 'Number',
  s.[Name] as 'Name',
  st.Flag as 'Type',
  s.CexAcronym as 'Acronym',
  s.Latitude as 'Latitude',
  s.Longitude as 'Longitude',
  ci.[Name] as 'City',
  r.[Name] as 'Region',
  co.[Name] as 'Country',
  m.[Name] as 'Market',
  mr.[Name] as 'MarketRegion'
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