CREATE VIEW [dbo].[vwOfficeLauncherV2] AS
SELECT EventTime, EventDate, EventName, EventCount, ViewName, ViewCount, DeviceType, 
       SessionId as 'SessionID', Continent, Country, Province, City, StoreNumber
FROM InputOfficeLauncherTelemetry 
WHERE 
((EventName in ('Word opened', 'OneNote opened', 'PowerPoint opened', 'OneDrive opened', 'Excel opened')) OR 
(ViewName in ('Word', 'OneNote', 'PowerPoint', 'OneDrive', 'Excel'))) AND
StoreNumber IS NOT NULL