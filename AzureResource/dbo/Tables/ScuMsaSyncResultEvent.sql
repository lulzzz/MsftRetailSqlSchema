CREATE TABLE [dbo].[ScuMsaSyncResultEvent] (
    [Id]                 INT              IDENTITY (1, 1) NOT NULL,
    [DateAdded]          DATETIME         DEFAULT (getdate()) NULL,
    [MSA]                VARCHAR (100)    NULL,
    [SyncJobId]          UNIQUEIDENTIFIER NULL,
    [SyncResult]         BIT              NULL,
    [SyncError]          VARCHAR (500)    NULL,
    [EventType]          VARCHAR (200)    NULL,
    [ObjectName]         VARCHAR (200)    NULL,
    [AdfSliceIdentifier] BINARY (32)      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

