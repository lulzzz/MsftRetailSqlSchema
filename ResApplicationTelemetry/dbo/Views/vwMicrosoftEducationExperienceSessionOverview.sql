-- MSRETEL-348 (05.11.2017): Aggregate Music Experience session data (useful for Power BI reports, for example)

CREATE VIEW [dbo].[vwMicrosoftEducationExperienceSessionOverview] AS
WITH Event_CTE 
AS  
(
SELECT
  EventCount,
  SessionID,
  EventName
FROM
  vwMicrosoftEducationExperienceSessionActivity
WHERE 
  EventName is not null
),

Event_PVT_CTE
AS
(
select * from Event_CTE
PIVOT
(
  SUM(EventCount)
  FOR EventName in ([Sway opened], [Microsoft Teams opened])
) as pvt
),

View_CTE 
AS  
(
SELECT
  ViewCount,
  SessionID,
  ViewName
FROM
  vwMicrosoftEducationExperienceSessionActivity
WHERE 
  ViewName is not null
),
View_PVT_CTE
AS
(
select * from View_CTE
PIVOT
(
  SUM(ViewCount)
  FOR ViewName in ([Sway], [Microsoft Teams])
) as pvt
),
SessionEventDate_CTE
AS
(
select  distinct SessionId as 'SessionID'
,       first_value(cast(EventTime as date)) over (partition by SessionID order by EventTime asc) as [EventDate]
from    InputOfficeLauncherTelemetry
)

select 
  sum(tbl1.EventCount) as 'EventCount', 
  sum(tbl1.ViewCount) as 'ViewCount', 
  1 as 'SessionCount',
  tbl1.StoreNumber, 
  tbl1.SessionID, 
  tbl4.EventDate,
  tbl2.[Sway opened] as 'EventSwayOpened', tbl2.[Microsoft Teams opened] as 'EventTeamsOpened',
  tbl3.[Sway] as 'ViewSway', tbl3.[Microsoft Teams] as 'ViewTeams'
from 
  vwMicrosoftEducationExperienceSessionActivity tbl1,
  Event_PVT_CTE tbl2,
  View_PVT_CTE tbl3,
  SessionEventDate_CTE tbl4

where 
  tbl1.SessionID = tbl2.SessionID AND
  tbl1.SessionID = tbl3.SessionID AND
  tbl1.SessionID = tbl4.SessionID
group by 
   tbl1.StoreNumber, tbl1.SessionID, tbl4.EventDate, 
   tbl2.[Sway opened], tbl2.[Microsoft Teams opened],
   tbl3.[Sway], tbl3.[Microsoft Teams]