-- (10.21.2016): initial version

CREATE PROCEDURE [dbo].[uspProcessAirWatchDevice]
  @deviceId INT,
  @udid VARCHAR(50),
  @imei VARCHAR (50),
  @serialNumber VARCHAR(50),
  @ipAddress VARCHAR(50),
  @macAddress VARCHAR(50),
  @assetNumber VARCHAR(50),
  @platform VARCHAR(50),
  @model VARCHAR(50),
  @operatingSystem VARCHAR(50),
  @wifiIPAddress VARCHAR(50),
  @wifiMacAddress VARCHAR(50),
  @latitude VARCHAR(50),
  @longitude VARCHAR(50),
  @lastSeen DATETIME,
  @userName VARCHAR(50)
AS
BEGIN

    UPDATE dbo.AirWatchDevice SET 
	    ModifiedAt = GETDATE(), 
		LastSeen = @lastSeen,
		/*DeviceId = @deviceId,*/
		Udid = @udid,
		Imei = @imei,
		SerialNumber = @serialNumber,
		IpAddress = @ipAddress,
		MacAddress = @macAddress,
		AssetNumber = @assetNumber, 
		OsPlatform = @platform,
		Model = @model, 
		OperatingSystem = @operatingSystem,
		WifiIPAddress = @wifiIPAddress,
		WifiMacAddress = @wifiMacAddress,
		Latitude = @latitude,
		Longitude = @longitude,
		UserName = @userName
	WHERE 
	    DeviceId = @deviceId

    IF @@ROWCOUNT=0
    INSERT INTO dbo.AirWatchDevice 
	    (CreatedAt, ModifiedAt, LastSeen, DeviceId, Udid, Imei, SerialNumber, MacAddress, AssetNumber,OsPlatform,
		Model, OperatingSystem, WifiIPAddress, WifiMacAddress, Latitude, Longitude, UserName) 
    VALUES 
	    (GETDATE(), GETDATE(), @lastSeen, @deviceId,@udid,@imei,@serialNumber,@macAddress,@assetNumber,@platform,
		@model,@operatingSystem,@wifiIPAddress,@wifiMacAddress,@latitude,@longitude, @userName)

END