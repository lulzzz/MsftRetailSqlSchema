CREATE TABLE [dbo].[HealthMonitorResult] (
    [id]              INT          IDENTITY (1, 1) NOT NULL,
    [health_mon_id]   INT          NULL,
    [device_id]       INT          NOT NULL,
    [store_number]    INT          NULL,
    [health_state]    VARCHAR (50) NULL,
    [health_state_id] INT          NULL,
    [actual]          VARCHAR (50) NULL,
    [expected]        VARCHAR (50) NULL,
    [passed]          INT          NULL,
    [date_passed]     DATETIME     NULL,
    [created_at]      DATETIME     NULL,
    [modified_at]     DATETIME     NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_HealthMonitorResult_DevId] FOREIGN KEY ([device_id]) REFERENCES [dbo].[Device] ([device_id]),
    CONSTRAINT [FK_HealthMonitorResult_HmId] FOREIGN KEY ([health_mon_id]) REFERENCES [dbo].[HealthMonitor] ([id]),
    CONSTRAINT [FK_HealthMonitorResult_HsId] FOREIGN KEY ([health_state_id]) REFERENCES [dbo].[HealthState] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IX_HealthMonitorResult_ModifiedAt]
    ON [dbo].[HealthMonitorResult]([modified_at] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_HealthMonitorResult_DevId]
    ON [dbo].[HealthMonitorResult]([device_id] ASC);

