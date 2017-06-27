CREATE VIEW [vwCurrentHealthPointsByStore] AS
SELECT
    SUM(t.DeviceHealthPoints) as 'HealthPoints', 
	COUNT(t.DeviceId) as 'DeviceCount',
	t.StoreNumber
FROM vwCurrentDevice t
group by t.StoreNumber