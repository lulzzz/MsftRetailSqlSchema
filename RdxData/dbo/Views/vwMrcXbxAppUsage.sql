-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcXbxAppUsage] AS

SELECT
  tbl1.DateAdded,
  tbl1.ReportDateId as 'ReportDateID',
  tbl1.ReportDate,
  tbl1.ProductName,
  tbl1.PakcageFullName as 'PackageFullName',
  tbl1.StoreNumber,
  tbl1.RetailerLocation,
  tbl1.MSA as 'Msa',
  tbl1.HardwareId as 'HardwareID',
  tbl1.XboxTitleId as 'XboxTitleID',
  tbl1.InFocusDurationSec,
  tbl1.UserActiveDurationSec,
  tbl1.FriendlyAppType,
  tbl1.[Type],
  tbl1.IsAutoInstall,
  tbl1.IsBackCompat
FROM
  XbxAppUsage tbl1