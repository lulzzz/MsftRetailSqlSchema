CREATE TABLE [dbo].[RdxCustomerSessions] (
    [Id]                 BIGINT           IDENTITY (1, 1) NOT NULL,
    [DateAdded]          DATETIME         DEFAULT (getdate()) NULL,
    [EventDate]          DATE             NULL,
    [DeviceId]           VARCHAR (50)     NULL,
    [UsageTimeS]         INT              NULL,
    [SessionId]          UNIQUEIDENTIFIER NULL,
    [Processed]          INT              DEFAULT ((0)) NULL,
    [AdfSliceIdentifier] BINARY (32)      NULL,
    CONSTRAINT [PK_RdxCustomerSessions_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RdxCustomerSessions_AggregatedSearch]
    ON [dbo].[RdxCustomerSessions]([EventDate] ASC, [DeviceId] ASC, [SessionId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RdxCustomerSessions_Processed]
    ON [dbo].[RdxCustomerSessions]([Processed] ASC);

