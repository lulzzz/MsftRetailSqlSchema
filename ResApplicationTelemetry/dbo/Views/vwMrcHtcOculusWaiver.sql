CREATE VIEW [dbo].[vwMrcHtcOculusWaiver] AS
SELECT
    tbl1.id as 'ID',
    tbl1.CompletedDate, 
	tbl1.StoreNumber,
	tbl1.EnvelopeID, 
	tbl1.Experience
FROM 
    ViveOculusExperienceReport tbl1