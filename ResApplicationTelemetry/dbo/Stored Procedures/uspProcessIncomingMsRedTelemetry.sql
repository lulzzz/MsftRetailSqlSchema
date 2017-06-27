-- Azure Stream Analytics (ASA) inserts telemetry into this table, where this SQL code then processes it

CREATE PROCEDURE dbo.[uspProcessIncomingMsRedTelemetry]
AS
BEGIN

DECLARE @AsaInputId INT 
DECLARE @ClientIp VARCHAR(50)
DECLARe @StoreNumber INT


DECLARE AsaInput_Cursor CURSOR FOR 
	SELECT Id, ClientIp FROM InputMsRedDashboardTelemetry WHERE Processed = 0

OPEN AsaInput_Cursor 

FETCH NEXT FROM AsaInput_Cursor INTO
    @AsaInputId, @ClientIp

	WHILE @@FETCH_STATUS = 0
	BEGIN
    
		--attempt to get the store number
		SET @StoreNumber = [dbo].[ufnGetStoreNumberByNetworkId](@ClientIp)

		--assign this telemetry a store
		UPDATE dbo.InputMsRedDashboardTelemetry SET StoreNumber = @StoreNumber WHERE Id = @AsaInputId;

		--mark this telemetry as processed!
		UPDATE dbo.InputMsRedDashboardTelemetry SET Processed = 1 WHERE Id = @AsaInputId;

		FETCH NEXT FROM AsaInput_Cursor INTO
		@AsaInputId, @ClientIp

	END

	CLOSE AsaInput_Cursor 
	DEALLOCATE AsaInput_Cursor

END