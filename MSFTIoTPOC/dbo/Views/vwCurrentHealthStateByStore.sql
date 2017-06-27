-- 09.01.2016 (MSRETEL-116): New health state id functionality
-- 09.09.2016 (MSRETEL-139): Exclude unassigned store devices (ie., store number is null)

CREATE VIEW [vwCurrentHealthStateByStore] AS
SELECT
	dbo.ufnGetHealthStateFromPercentage('S', t.HealthPercentage) as 'StoreHealthState',
	dbo.ufnGetHealthStateIdFromPercentage('S', t.HealthPercentage) as 'StoreHealthStateId',
	t.HealthPercentage as 'StoreHealthPercentage',
	t.HealthPoints as 'StoreHealthPoints',
	t.DeviceCount as 'StoreDeviceCount',
	t.StoreNumber
FROM vwCurrentHealthPercentageByStore t
WHERE t.StoreNumber IS NOT NULL