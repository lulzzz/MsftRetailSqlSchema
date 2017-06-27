CREATE VIEW [vwCurrentHealthPointsByStoreExperience] AS
SELECT
    SUM(t.DeviceHealthPoints) as 'HealthPoints', 
	COUNT(t.DeviceId) as 'DeviceCount',
	t.StoreNumber,
	t.ExperienceId
FROM vwCurrentDevice t
group by t.StoreNumber, t.ExperienceId