CREATE TABLE [dbo].[DeviceHistory] (
    [device_history_id]     INT           IDENTITY (1, 1) NOT NULL,
    [device_id]             INT           NULL,
    [modified_at]           DATETIME      NULL,
    [created_at]            DATETIME      NULL,
    [event_date]            DATE          NULL,
    [cs_name]               VARCHAR (50)  NULL,
    [os_build_number]       INT           NULL,
    [os_install_date]       VARCHAR (50)  NULL,
    [ip_address_v4]         VARCHAR (50)  NULL,
    [serial_number]         VARCHAR (50)  NULL,
    [store_number]          INT           NULL,
    [customer_id]           INT           NULL,
    [rdx_rac]               VARCHAR (50)  NULL,
    [rdx_sku]               VARCHAR (50)  NULL,
    [exp_buildtool_version] VARCHAR (50)  NULL,
    [exp_id]                INT           NULL,
    [health_state_id]       INT           NULL,
    [external_ip]           VARCHAR (50)  NULL,
    [wlan_ssid]             VARCHAR (50)  NULL,
    [microsoft_account]     VARCHAR (100) NULL,
    [local_account]         VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([device_history_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceHistory_DeviceID]
    ON [dbo].[DeviceHistory]([device_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DeviceHistory_Lookup]
    ON [dbo].[DeviceHistory]([event_date] ASC, [serial_number] ASC);

