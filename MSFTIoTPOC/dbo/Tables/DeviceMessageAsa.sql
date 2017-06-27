CREATE TABLE [dbo].[DeviceMessageAsa] (
    [id]                    INT           IDENTITY (1, 1) NOT NULL,
    [created_at]            DATETIME      NULL,
    [caption]               VARCHAR (50)  NULL,
    [os_build_number]       INT           NULL,
    [os_install_date]       VARCHAR (50)  NULL,
    [cs_name]               VARCHAR (50)  NULL,
    [manufacturer]          VARCHAR (50)  NULL,
    [model]                 VARCHAR (50)  NULL,
    [total_physical_memory] VARCHAR (50)  NULL,
    [ip_address_v4]         VARCHAR (50)  NULL,
    [mac_address]           VARCHAR (50)  NULL,
    [serial_number]         VARCHAR (50)  NULL,
    [rdx_rac]               VARCHAR (50)  NULL,
    [rdx_sku]               VARCHAR (50)  NULL,
    [exp_name]              VARCHAR (50)  NULL,
    [demo_category]         INT           DEFAULT ((0)) NULL,
    [en_ca_enabled]         INT           DEFAULT ((0)) NULL,
    [exp_buildtool_version] VARCHAR (50)  NULL,
    [external_ip]           VARCHAR (50)  NULL,
    [wlan_ssid]             VARCHAR (50)  NULL,
    [time_zone]             VARCHAR (100) NULL,
    [adobe_result]          INT           DEFAULT ((0)) NULL,
    [adobe_version]         VARCHAR (50)  DEFAULT (NULL) NULL,
    [office_build]          VARCHAR (50)  NULL,
    [office_release_ids]    VARCHAR (150) NULL,
    [office_platform]       VARCHAR (50)  NULL,
    [processor_name]        VARCHAR (100) NULL,
    [microsoft_account]     VARCHAR (100) NULL,
    [local_account]         VARCHAR (100) NULL,
    [stored_identities]     INT           NULL,
    [transaction_id]        INT           NULL,
    [processed]             INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceMessageAsa_processed]
    ON [dbo].[DeviceMessageAsa]([processed] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceMessageAsa_cs_name]
    ON [dbo].[DeviceMessageAsa]([cs_name] ASC);


GO
CREATE TRIGGER dbo.trgProcessDeviceMessageAsa
ON dbo.DeviceMessageAsa
AFTER INSERT
AS
		DECLARE	@return_value Int
		EXEC	@return_value = [dbo].[uspProcessDeviceMessage]