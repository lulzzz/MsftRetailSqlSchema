-- 06.26.2017 (MSRETEL-386): remove OEMSerialNumber from update (i.e., serial number does not change)

CREATE PROCEDURE uspOverwriteRdxDevices @RdxDevices [dbo].[RdxDevicesType] READONLY
AS
BEGIN

/*DeviceId,DeviceIp,OEMName,OEMModel,OEMSerialNumber,DeviceModel,RetailDeviceName,
		OSVersionFull,OSBranch,OSBuildNumber,OSInstallDate,Latitude,Longitude,AccuracyKm,
		Source, FirstOnlineDate, LastOnlineDate,Retailer, RAC, SKU, StoreId*/

MERGE [dbo].[RdxDevices] AS tpr
    USING @RdxDevices AS spr
    ON tpr.DeviceId = spr.DeviceId
WHEN MATCHED THEN 
    UPDATE SET tpr.DeviceId = spr.DeviceId, 
	           tpr.DeviceIp = spr.DeviceIp, 
			   tpr.OEMName = spr.OEMName,
			   tpr.OEMModel = spr.OEMModel,
			   --tpr.OEMSerialNumber = spr.OEMSerialNumber,
			   tpr.DeviceModel = spr.DeviceModel,
			   tpr.OSVersionFull = spr.OSVersionFull,
			   tpr.OSBranch = spr.OSBranch,
			   tpr.OSBuildNumber = spr.OSBuildNumber,
			   tpr.OSInstallDate = spr.OSInstallDate,
			   tpr.Latitude = spr.Latitude,
			   tpr.Longitude = spr.Longitude,
			   tpr.AccuracyKm = spr.AccuracyKm,
			   tpr.Source = spr.Source,
			   tpr.FirstOnlineDate = spr.FirstOnlineDate,
			   tpr.LastOnlineDate = spr.LastOnlineDate,
			   tpr.Retailer = spr.Retailer,
			   tpr.RAC = spr.RAC,
			   tpr.SKU = spr.SKU,
			   tpr.StoreId = spr.StoreId,
			   tpr.DeviceName = spr.DeviceName,
			   tpr.MDC1DeviceFamily = spr.MDC1DeviceFamily,
			   tpr.MDC2FormFactor = spr.MDC2FormFactor,
			   tpr.IsRetailPhone = spr.IsRetailPhone,
			   tpr.DateUpdated = getdate()
WHEN NOT MATCHED THEN 
    INSERT (DeviceId,DeviceIp,OEMName,OEMModel,OEMSerialNumber,DeviceModel,
		OSVersionFull,OSBranch,OSBuildNumber,OSInstallDate,Latitude,Longitude,AccuracyKm,
		Source, FirstOnlineDate, LastOnlineDate,Retailer, RAC, SKU, StoreId,DeviceName, 
		MDC1DeviceFamily,MDC2FormFactor,IsRetailPhone,DateAdded, DateUpdated) 
    VALUES(
		spr.DeviceId, 
	    spr.DeviceIp, 
		spr.OEMName,
		spr.OEMModel,
		spr.OEMSerialNumber,
		spr.DeviceModel,
		spr.OSVersionFull,
		spr.OSBranch,
		spr.OSBuildNumber,
		spr.OSInstallDate,
		spr.Latitude,
		spr.Longitude,
		spr.AccuracyKm,
		spr.Source,
		spr.FirstOnlineDate,
		spr.LastOnlineDate,
		spr.Retailer,
		spr.RAC,
		spr.SKU,
		spr.StoreId,
		spr.DeviceName,
		spr.MDC1DeviceFamily,
		spr.MDC2FormFactor,
		spr.IsRetailPhone,
		getdate(),
		getdate()
	)
;
END