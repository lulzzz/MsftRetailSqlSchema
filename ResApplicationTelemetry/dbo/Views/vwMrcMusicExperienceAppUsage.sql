-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [vwMrcMusicExperienceAppUsage] AS
select
    tbl1.event_time as 'EventTime',
	tbl1.event_name as 'EventName',
	tbl1.event_count as 'EventCount',
	tbl1.view_name as 'ViewName',
	tbl1.view_count as 'ViewCount',
	tbl1.session_id as 'SessionID',
	tbl1.position as 'Position',
	tbl1.is_music_playing as 'IsMusicPlaying',
	ROUND(((tbl1.duration_value / 10000000) / 60),1) as 'DurationValueMin',
	tbl1.duration_count as 'DurationCount',
	tbl1.device_type as 'DeviceType',
	tbl1.client_ip as 'ClientIP',
	tbl1.continent as 'Continent',
	tbl1.country as 'Country',
	tbl1.province as 'Province',
	tbl1.city as 'City',
	tbl1.store_number as 'StoreNumber'
from 
InputGrooveTelemetry tbl1
where 
    tbl1.session_id IS NOT NULL