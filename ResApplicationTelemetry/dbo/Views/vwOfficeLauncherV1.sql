CREATE VIEW [vwOfficeLauncherV1] AS
SELECT EventTime, EventDate, EventName, EventCount, ViewName, ViewCount, DeviceType, 
       SessionId as 'SessionID', Continent, Country, Province, City, StoreNumber
FROM InputOfficeLauncherTelemetry 
WHERE 
((EventName in ('Word opened', 'OneNote opened', 'Excel opened', 'PowerPoint opened')) OR 
(ViewName in ('Word', 'OneNote', 'Excel', 'PowerPoint'))) AND
StoreNumber IS NOT NULL