CREATE TABLE [dbo].[HealthMonitor] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [name]            VARCHAR (50)  NULL,
    [title]           VARCHAR (100) NULL,
    [message_fail]    VARCHAR (100) NULL,
    [expected]        VARCHAR (50)  NULL,
    [operator]        VARCHAR (50)  NULL,
    [health_state_id] INT           NULL,
    [active]          INT           NULL,
    [deleted]         INT           NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_HealthMonitor_HsId] FOREIGN KEY ([health_state_id]) REFERENCES [dbo].[HealthState] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IX_HealthMonitor_HealthStateId]
    ON [dbo].[HealthMonitor]([health_state_id] ASC);

