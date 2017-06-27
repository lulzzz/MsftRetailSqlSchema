CREATE TABLE [dbo].[ScuMsaSyncResult] (
    [Id]                    INT              IDENTITY (1, 1) NOT NULL,
    [DateAdded]             DATETIME         DEFAULT (getdate()) NULL,
    [MSA]                   VARCHAR (200)    NULL,
    [SyncJobId]             UNIQUEIDENTIFIER NULL,
    [SyncStartTime]         DATETIME         NULL,
    [SyncEndTime]           DATETIME         NULL,
    [SyncJobResult]         BIT              NULL,
    [SyncJobError]          VARCHAR (500)    NULL,
    [LoginResult]           BIT              NULL,
    [LoginError]            VARCHAR (200)    NULL,
    [LoginErrorDescription] VARCHAR (1000)   NULL,
    [AdfSliceIdentifier]    BINARY (32)      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

