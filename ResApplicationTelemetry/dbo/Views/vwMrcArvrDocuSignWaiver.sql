-- MSRETEL-380 (06.30.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcArvrDocuSignWaiver] AS
SELECT
    tbl1.Id as 'ID',
    tbl1.CompletedDate as 'CompletedDateTime',
	CONVERT(date,  tbl1.CompletedDate) as 'CompletedDate',
	tbl1.StoreNumber,
	tbl1.EnvelopeID, 
	tbl1.Experience
FROM 
    ViveOculusExperienceReport tbl1