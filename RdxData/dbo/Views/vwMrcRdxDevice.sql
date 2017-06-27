-- MSRETEL-380 (06.23.2017): microsoft retail campaign data feed

CREATE VIEW [dbo].[vwMrcRdxDevice] AS
SELECT top 200
  tbl1.DateAdded,
  tbl1.DateUpdated,
  tbl1.DeviceId as 'DeviceID',
  tbl1.DeviceIp as 'DeviceIP',
  tbl1.OEMName as 'OemName',
  tbl1.OEMModel as 'OemModel',
  tbl1.OEMSerialNumber as 'OemSerialNumber',
  tbl1.DeviceModel,
  tbl1.OSVersionFull,
  tbl1.OSBranch,
  tbl1.OSBuildNumber,
  tbl1.OSInstallDate,
  tbl1.OSOOBEDateTime as 'OSOobeDateTime',
  tbl1.Latitude,
  tbl1.Longitude,
  tbl1.AccuracyKm as 'AccuracyKM',
  tbl1.[Source],
  tbl1.FirstOnlineDate,
  tbl1.LastOnlineDate,
  tbl1.Retailer,
  tbl1.RAC as 'Rac',
  tbl1.SKU as 'Sku',
  tbl1.StoreId as 'StoreID',
  tbl1.DeviceName,
  tbl1.MDC1DeviceFamily as 'Mdc1DeviceFamily',
  tbl1.MDC2FormFactor as 'Mdc2FormFactor',
  tbl1.IsRetailPhone,
  tbl1.StoreNumber
FROM
  RdxDevices tbl1
WHERE
  tbl1.DateAdded >= DATEADD(day,-5,getdate())