CREATE VIEW [vwCurrentHealthPercentageByStoreExperience] AS
SELECT
    ((t.HealthPoints / t.DeviceCount) * 100) as 'HealthPercentage',
	t.HealthPoints,
	t.DeviceCount,
	t.StoreNumber,
        t.ExperienceId
FROM vwCurrentHealthPointsByStoreExperience t