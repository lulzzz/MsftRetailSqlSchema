CREATE TABLE [dbo].[RdxAppUsageLast30Days] (
    [Id]                  BIGINT           IDENTITY (1, 1) NOT NULL,
    [DateAdded]           DATETIME         DEFAULT (getdate()) NULL,
    [EventDate]           DATE             NULL,
    [EventTime]           DATETIME         NULL,
    [EventWeekDate]       DATE             NULL,
    [EventWeek]           INT              NULL,
    [PrevEventWeekDate]   DATE             NULL,
    [PrevEventWeek]       INT              NULL,
    [DeviceId]            VARCHAR (50)     NULL,
    [SessionId]           UNIQUEIDENTIFIER NULL,
    [AppName]             VARCHAR (250)    NULL,
    [AppTitle]            VARCHAR (250)    NULL,
    [AppVersion]          VARCHAR (250)    NULL,
    [AppType]             VARCHAR (50)     NULL,
    [Category]            VARCHAR (150)    NULL,
    [UserActiveDurationS] DECIMAL (38, 3)  NULL,
    [LaunchCount]         INT              NULL,
    CONSTRAINT [PK_RdxAppUsageLast30Days_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RdxAppUsageLast30Days_AggregatedSearch]
    ON [dbo].[RdxAppUsageLast30Days]([EventWeekDate] ASC, [EventWeek] ASC, [EventDate] ASC, [DeviceId] ASC, [SessionId] ASC, [AppName] ASC, [AppTitle] ASC, [AppVersion] ASC, [AppType] ASC, [Category] ASC);

