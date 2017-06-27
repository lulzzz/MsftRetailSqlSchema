-- MSRETEL-171 (11.28.2016): Create this new SP to offload processing time from DeviceMessageAsa to DeviceMessage 
--                           Note: This reduces contention between ASA job and primary SP, uspProcessDeviceMessage
-- MSRETEL-367 (05.30.2017): Deprecated


CREATE PROCEDURE [dbo].[uspMoveDeviceMessageAsa]
AS
BEGIN
        -- flag the newly inserted records with a unique transaction id 
        DECLARE @transId INT
		SET @transId = (select ROUND((RAND() * 100000),0))
	    UPDATE [dbo].[DeviceMessageAsa] SET transaction_id = @transId WHERE transaction_id = 0
		-- copy these newly inserted records, where additional processing will be done on them
	    INSERT INTO [dbo].[DeviceMessage] SELECT * FROM [dbo].[DeviceMessageAsa] WHERE transaction_id = @transId
		-- purge the newly inserted records after they have been copied
	    DELETE [dbo].[DeviceMessageAsa] WHERE transaction_id = @transId
END