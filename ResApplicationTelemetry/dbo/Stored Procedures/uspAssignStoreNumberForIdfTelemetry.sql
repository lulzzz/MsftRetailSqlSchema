CREATE PROCEDURE dbo.[uspAssignStoreNumberForIdfTelemetry]
AS
BEGIN

DECLARE @asa_output_id INT, @client_ip VARCHAR(50), @store_number INT, @client_ip_count INT

DECLARE AsaOutput_Cursor CURSOR FOR 
	SELECT COUNT(Id) AS 'IpCount', ClientIp from InputIdfTelemetry where Processed = 2 group by ClientIp order by ClientIp

OPEN AsaOutput_Cursor 

FETCH NEXT FROM AsaOutput_Cursor INTO
    @client_ip_count, @client_ip

	WHILE @@FETCH_STATUS = 0
	BEGIN
    
		--attempt to get the store number
		SET @store_number = [dbo].[ufnGetStoreNumberByNetworkId](@client_ip)

		--assign this telemetry a store
		UPDATE dbo.InputIdfTelemetry SET StoreNumber = @store_number, Processed = 1 WHERE ClientIp = @client_ip;

		FETCH NEXT FROM AsaOutput_Cursor INTO
    @client_ip_count, @client_ip

	END

	CLOSE AsaOutput_Cursor 
	DEALLOCATE AsaOutput_Cursor

END