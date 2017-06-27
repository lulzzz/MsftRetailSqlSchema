CREATE VIEW [vwCurrentHealthPercentageByStore] AS
SELECT
    ((t.HealthPoints / t.DeviceCount) * 100) as 'HealthPercentage',
	t.HealthPoints,
	t.DeviceCount,
	t.StoreNumber
FROM vwCurrentHealthPointsByStore t