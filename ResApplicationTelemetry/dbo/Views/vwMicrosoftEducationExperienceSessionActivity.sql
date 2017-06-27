-- MSRETEL-348 (05.11.2017): Targets only Music Experience activity (e.g., filters out Office Launcher activity data)


CREATE VIEW [dbo].[vwMicrosoftEducationExperienceSessionActivity] AS
SELECT tbl1.EventTime, tbl1.EventDate, tbl1.EventName, tbl1.EventCount, tbl1.ViewName, tbl1.ViewCount, tbl1.DeviceType, 
       tbl1.SessionId as 'SessionID', tbl1.Continent, tbl1.Country, tbl1.Province, tbl1.City, tbl1.StoreNumber
FROM [dbo].[InputOfficeLauncherTelemetry] tbl1
WHERE
((tbl1.EventName in ('Sway opened', 'Microsoft Teams opened')) OR 
(tbl1.ViewName in ('Sway', 'Microsoft Teams'))) AND
tbl1.StoreNumber IS NOT NULL