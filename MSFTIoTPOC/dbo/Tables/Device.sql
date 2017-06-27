CREATE TABLE [dbo].[Device] (
    [device_id]             INT            IDENTITY (1, 1) NOT NULL,
    [modified_at]           DATETIME       NULL,
    [created_at]            DATETIME       NULL,
    [last_health_check_at]  DATETIME       NULL,
    [caption]               VARCHAR (50)   NULL,
    [os_build_number]       INT            NULL,
    [os_install_date]       VARCHAR (50)   NULL,
    [cs_name]               VARCHAR (50)   NULL,
    [manufacturer]          VARCHAR (50)   NULL,
    [model]                 VARCHAR (50)   NULL,
    [total_physical_memory] VARCHAR (50)   NULL,
    [ip_address_v4]         VARCHAR (50)   NULL,
    [serial_number]         VARCHAR (50)   NULL,
    [store_number]          INT            NULL,
    [rdx_rac]               VARCHAR (50)   NULL,
    [rdx_sku]               VARCHAR (50)   NULL,
    [exp_buildtool_version] VARCHAR (50)   NULL,
    [exp_name]              VARCHAR (50)   NULL,
    [demo_category]         INT            DEFAULT ((0)) NULL,
    [en_ca_enabled]         INT            DEFAULT ((0)) NULL,
    [exp_id]                INT            NULL,
    [external_ip]           VARCHAR (50)   NULL,
    [wlan_ssid]             VARCHAR (50)   NULL,
    [time_zone]             VARCHAR (100)  NULL,
    [adobe_installed]       INT            NULL,
    [office_build]          VARCHAR (50)   NULL,
    [office_release_ids]    VARCHAR (150)  NULL,
    [office_platform]       VARCHAR (50)   NULL,
    [office_version]        INT            NULL,
    [processor_name]        VARCHAR (100)  NULL,
    [microsoft_account]     VARCHAR (100)  NULL,
    [local_account]         VARCHAR (100)  NULL,
    [stored_identities]     INT            NULL,
    [health_state]          VARCHAR (50)   NULL,
    [health_state_id]       INT            NULL,
    [health_points]         DECIMAL (2, 1) NULL,
    [health_details]        VARCHAR (50)   NULL,
    [deleted]               INT            NULL,
    PRIMARY KEY CLUSTERED ([device_id] ASC),
    CONSTRAINT [FK_Device_ExpId] FOREIGN KEY ([exp_id]) REFERENCES [dbo].[Experience] ([id]),
    CONSTRAINT [FK_Device_HsId] FOREIGN KEY ([health_state_id]) REFERENCES [dbo].[HealthState] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Device_last_health_check_at]
    ON [dbo].[Device]([last_health_check_at] ASC);


GO
CREATE NONCLUSTERED INDEX [nci_wi_Device_5A720F726EEA14F0245D89813F256BF9]
    ON [dbo].[Device]([demo_category] ASC, [exp_id] ASC, [store_number] ASC, [modified_at] ASC)
    INCLUDE([caption], [created_at], [cs_name], [exp_buildtool_version], [external_ip], [health_points], [health_state], [health_state_id], [ip_address_v4], [manufacturer], [model], [os_build_number], [rdx_rac], [rdx_sku], [serial_number], [time_zone], [total_physical_memory], [wlan_ssid]);


GO
CREATE NONCLUSTERED INDEX [nci_wi_Device_CB21A04E087DA8AC2DA1B840150F772D]
    ON [dbo].[Device]([store_number] ASC, [modified_at] ASC)
    INCLUDE([health_points]);


GO
CREATE NONCLUSTERED INDEX [IX_demo_device_en_ca_enabled]
    ON [dbo].[Device]([en_ca_enabled] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_demo_device_category]
    ON [dbo].[Device]([demo_category] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Device_experience_name]
    ON [dbo].[Device]([exp_name] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Device_ExpId]
    ON [dbo].[Device]([exp_id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Device_modified_at]
    ON [dbo].[Device]([modified_at] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Device_store_number]
    ON [dbo].[Device]([store_number] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_experience_state_device_id]
    ON [dbo].[Device]([device_id] ASC);


GO
CREATE NONCLUSTERED INDEX [nci_wi_Device_D9E728237C4EA6261F595E1130682329]
    ON [dbo].[Device]([exp_id] ASC, [store_number] ASC, [modified_at] ASC)
    INCLUDE([caption], [created_at], [cs_name], [device_id], [exp_buildtool_version], [external_ip], [health_points], [health_state], [health_state_id], [ip_address_v4], [manufacturer], [model], [os_build_number], [rdx_rac], [rdx_sku], [serial_number], [time_zone], [total_physical_memory], [wlan_ssid]);


GO
CREATE NONCLUSTERED INDEX [IX_experience_state_health_state]
    ON [dbo].[Device]([health_state] ASC);


GO
CREATE NONCLUSTERED INDEX [nci_wi_Device_DDB63E48FD7A27467481]
    ON [dbo].[Device]([cs_name] ASC);


GO
CREATE NONCLUSTERED INDEX [nci_wi_Device_F6ACDB2A74B426627994]
    ON [dbo].[Device]([store_number] ASC, [modified_at] ASC)
    INCLUDE([caption], [created_at], [cs_name], [device_id], [exp_buildtool_version], [exp_name], [external_ip], [health_state], [ip_address_v4], [manufacturer], [model], [rdx_rac], [rdx_sku], [serial_number], [total_physical_memory], [wlan_ssid]);


GO
CREATE NONCLUSTERED INDEX [nci_wi_Device_FD09F71ACB6FC9D5083D]
    ON [dbo].[Device]([serial_number] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Device_HealthStateId]
    ON [dbo].[Device]([health_state_id] ASC);

