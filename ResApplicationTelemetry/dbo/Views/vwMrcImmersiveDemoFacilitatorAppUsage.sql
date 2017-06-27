-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcImmersiveDemoFacilitatorAppUsage] AS
SELECT
    tbl1.EventTime, 
	tbl1.EventDate,
	tbl1.EventName, 
	tbl1.EventCount, 
	tbl1.ExperienceName,
	tbl1.DeviceType,
	tbl1.ClientIp as 'ClientIP',
	tbl1.Continent as 'Continent',
	tbl1.Country as 'Country',
	tbl1.Province as 'Province',
	tbl1.City as 'City',
	tbl1.CustomCity,
	tbl1.PageViewDuration,
	tbl1.PageViewDurationSecs,
	tbl1.VideoPlayDuration,
	tbl1.VideoPlayDurationSecs,
	tbl1.StoreNumber
FROM 
    InputIdfTelemetry tbl1
WHERE 
    tbl1.StoreNumber IS NOT NULL