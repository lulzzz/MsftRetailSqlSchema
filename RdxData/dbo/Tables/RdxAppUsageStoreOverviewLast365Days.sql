CREATE TABLE [dbo].[RdxAppUsageStoreOverviewLast365Days] (
    [Id]                       BIGINT       IDENTITY (1, 1) NOT NULL,
    [DateAdded]                DATETIME     DEFAULT (getdate()) NULL,
    [EventDate]                DATE         NULL,
    [EventWeekDate]            DATE         NULL,
    [EventWeekNumber]          INT          NULL,
    [EventQuarter]             INT          NULL,
    [TotalUserActiveDurationS] INT          NULL,
    [TotalAppsLaunchCount]     INT          NULL,
    [TotalSessionCount]        INT          NULL,
    [TotalDeviceCount]         INT          NULL,
    [AverageSessionDurationS]  INT          NULL,
    [StoreNumber]              INT          NULL,
    [Rac]                      VARCHAR (50) NULL,
    CONSTRAINT [PK_RdxAppUsageStoreOverviewLast365Days_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

