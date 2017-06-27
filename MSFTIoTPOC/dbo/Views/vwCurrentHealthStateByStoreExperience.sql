-- 09.01.2016 (MSRETEL-116): updated to support new health status id functionality

CREATE VIEW [vwCurrentHealthStateByStoreExperience] AS
SELECT
	t.StoreNumber,
	t.ExperienceId,
	dbo.ufnGetHealthStateFromPercentage('E', t.HealthPercentage) as 'ExperienceHealthState',
	dbo.ufnGetHealthStateIdFromPercentage('E', t.HealthPercentage) as 'ExperienceHealthStateId',
	t.HealthPercentage as 'ExperienceHealthPercentage',
	t.HealthPoints as 'ExperienceHealthPoints',
	t.DeviceCount as 'ExperienceDeviceCount',
	dbo.ufnGetHealthStateFromPercentage('E', t.HealthPercentage) as 'StoreHealthState',
	dbo.ufnGetHealthStateIdFromPercentage('S', r.StoreHealthPercentage) as 'StoreHealthStateId',
	r.StoreHealthPercentage as 'StoreHealthPercentage',
	r.StoreHealthPoints as 'StoreHealthPoints',
	r.StoreDeviceCount as 'StoreDeviceCount'
FROM vwCurrentHealthPercentageByStoreExperience t, vwCurrentHealthStateByStore r
WHERE t.StoreNumber = r.StoreNumber