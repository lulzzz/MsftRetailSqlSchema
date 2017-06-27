-- 06.26.2017 (MSRETEL-386): store assignment and serial number cleanup

CREATE PROCEDURE [uspProcessRdxDevices]
AS
BEGIN

--Cursor variables
DECLARE @Id INT, @DeviceIp VARCHAR(50), @OEMSerialNumber VARCHAR(50), @DeviceName VARCHAR(50), @StoreId VARCHAR(50)
--Temp variables
DECLARE @TmpStoreNumber INT, @TmpSerialNumber VARCHAR(50)

DECLARE RdxDevicesCursor CURSOR FOR 
	SELECT Id, DeviceIp, OEMSerialNumber, DeviceName, StoreId
	FROM [dbo].[RdxDevices] 
	WHERE Processed = 0

OPEN RdxDevicesCursor 

FETCH NEXT FROM RdxDevicesCursor INTO
@Id, @DeviceIp, @OEMSerialNumber, @DeviceName, @StoreId

WHILE @@FETCH_STATUS = 0
BEGIN

	--attempt to get the store number
	SET @TmpStoreNumber = [dbo].[ufnGetStoreNumberByIp](@DeviceIp)

	--if store number lookup failed by ip, try store acronym
	IF ((@TmpStoreNumber IS NULL) AND (@DeviceName IS NOT NULL))
	  SET @TmpStoreNumber = [dbo].[ufnGetStoreNumberByAcronym](@DeviceName)

	--if store number lookup failed by ip and acronym, default to available store id (which is less reliable, but better than nothing)
	SET @StoreId = TRIM(REPLACE(REPLACE(@StoreId, 'store', ''),'#','')) -- 05/04/2017: some store numbers manually entered with wrong format (e.g., 'store #8012')
	IF ((@TmpStoreNumber IS NULL) AND (ISNUMERIC(@StoreId) = 1))
	  SET @TmpStoreNumber = @StoreId

    --not all manufacturers populate serial number (e.g., TMAX, INTEL_CORPORATION)
	IF ((@OEMSerialNumber = '') OR (@OEMSerialNumber = 'To be filled by O.E.M.') OR 
	(@OEMSerialNumber IS NULL) OR (@OEMSerialNumber = 'Default string') OR 
	(@OEMSerialNumber = 'As printed in the D cover') OR (@OEMSerialNumber = 'System Serial Number'))
	  SET @TmpSerialNumber = 'SN' + @DeviceName
	ELSE
	  SET @TmpSerialNumber = @OEMSerialNumber

	UPDATE [dbo].[RdxDevices] SET StoreNumber = @TmpStoreNumber, OEMSerialNumber = @TmpSerialNumber, Processed = 1 WHERE Id = @Id

	FETCH NEXT FROM RdxDevicesCursor INTO
	@Id, @DeviceIp, @OEMSerialNumber, @DeviceName, @StoreId
  
END

CLOSE RdxDevicesCursor 
DEALLOCATE RdxDevicesCursor


END