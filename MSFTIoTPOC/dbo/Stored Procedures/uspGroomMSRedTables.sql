-- MSRETEL-373 (06.05.2017): add database grooming

CREATE PROCEDURE [dbo].[uspGroomMSRedTables]
AS
BEGIN
	
  DECLARE @NumberRecordsProcessed INT
  SET @NumberRecordsProcessed = 0
	
  BEGIN TRANSACTION
  BEGIN TRY
    DELETE FROM DeviceMessageAsa WHERE created_at <= DATEADD(DAY,-3,getdate())
    DELETE FROM HealthMonitorResult WHERE modified_at <= DATEADD(DAY,-2,getdate())
    COMMIT TRANSACTION
  END TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
  END CATCH

  RETURN @@ERROR

END