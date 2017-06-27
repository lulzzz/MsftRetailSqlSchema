-- MSRETEL-366 (05.19.2017): Records daily device history
-- MSRETEL-366 (05.25.2017): adding device_id to daily device history
-- MSRETEL-369 (06.02.2017): add os build & install date
-- MSRETEL-383 (06.18.2017): add customer_id to device history

CREATE PROCEDURE dbo.uspCaptureDeviceHistory
    @device_id INT,
	@cs_name VARCHAR (50),
	@os_build_number INT,
	@os_install_date VARCHAR (50),
	@ip_address_v4 VARCHAR (50),
	@serial_number VARCHAR (50),
	@store_number INT,
	@rdx_rac VARCHAR (50),
	@rdx_sku VARCHAR (50),
	@exp_buildtool_version VARCHAR (50),
	@exp_id INT,
	@health_state_id INT,
	@external_ip VARCHAR (50),
	@wlan_ssid VARCHAR (50),
	@microsoft_account VARCHAR (100),
	@local_account VARCHAR (100),
	@customer_id INT


AS
BEGIN

	DECLARE @event_date DATE;
	
	SET @event_date = CONVERT(date, getdate());

	UPDATE dbo.DeviceHistory SET 
	    modified_at = GETDATE(), device_id = @device_id, cs_name = @cs_name, 
		os_build_number = @os_build_number, os_install_date = @os_install_date,
		ip_address_v4 = @ip_address_v4, store_number = @store_number, rdx_rac = @rdx_rac, rdx_sku = @rdx_sku, 
		exp_buildtool_version = @exp_buildtool_version, exp_id = @exp_id,
		health_state_id = @health_state_id, external_ip = @external_ip, wlan_ssid = @wlan_ssid, 
		microsoft_account = @microsoft_account, local_account = @local_account, customer_id = @customer_id
        WHERE event_date = @event_date AND serial_number = @serial_number
        IF @@ROWCOUNT=0
          INSERT INTO dbo.DeviceHistory (created_at, modified_at, event_date, device_id, cs_name, os_build_number, os_install_date, ip_address_v4, store_number, rdx_rac, rdx_sku, 
		    exp_buildtool_version, exp_id, health_state_id, external_ip, wlan_ssid, microsoft_account, local_account, serial_number, customer_id) 
            VALUES (GETDATE(), GETDATE(), @event_date, @device_id, @cs_name, @os_build_number, @os_install_date, @ip_address_v4, @store_number, @rdx_rac, @rdx_sku, @exp_buildtool_version,
			        @exp_id, @health_state_id, @external_ip, @wlan_ssid, @microsoft_account, @local_account, @serial_number, @customer_id); 

END