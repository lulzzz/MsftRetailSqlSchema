CREATE TABLE [dbo].[RdxAppUsage] (
    [Id]                     BIGINT           IDENTITY (1, 1) NOT NULL,
    [DateAdded]              DATETIME         DEFAULT (getdate()) NULL,
    [EventDate]              DATE             NULL,
    [EventTime]              DATETIME         NULL,
    [DeviceId]               VARCHAR (50)     NULL,
    [AppId]                  VARCHAR (300)    NULL,
    [AppName]                VARCHAR (150)    NULL,
    [AppTitle]               VARCHAR (250)    NULL,
    [AppType]                VARCHAR (50)     NULL,
    [AppVersion]             VARCHAR (150)    NULL,
    [Category]               VARCHAR (150)    NULL,
    [UserActiveDurationS]    DECIMAL (10, 3)  NULL,
    [InteractivityDurationS] DECIMAL (10, 3)  NULL,
    [KeyboardInputSecCount]  INT              NULL,
    [MouseInputSecCount]     INT              NULL,
    [TouchInputSecCount]     INT              NULL,
    [PenInputSecCount]       INT              NULL,
    [LaunchCount]            INT              NULL,
    [SessionId]              UNIQUEIDENTIFIER NULL,
    [Processed]              INT              DEFAULT ((0)) NULL,
    [AdfSliceIdentifier]     BINARY (32)      NULL,
    CONSTRAINT [PK_RdxAppUsage_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RdxAppUsage_StoreOverviewA]
    ON [dbo].[RdxAppUsage]([EventDate] ASC, [DeviceId] ASC)
    INCLUDE([UserActiveDurationS], [LaunchCount], [SessionId]);


GO
CREATE NONCLUSTERED INDEX [IX_RdxAppUsage_Processed]
    ON [dbo].[RdxAppUsage]([Processed] ASC);

