CREATE TABLE [dbo].[MSLxftSurfaceHubRetailDemoAppUsage] (
    [ID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [DateLoaded]  DATETIME      DEFAULT (getdate()) NULL,
    [EventTime]   DATETIME      NULL,
    [EventDate]   DATETIME      NULL,
    [EventName]   VARCHAR (100) NULL,
    [EventCount]  INT           NULL,
    [DeviceType]  VARCHAR (50)  NULL,
    [SessionId]   VARCHAR (150) NULL,
    [HubName]     VARCHAR (50)  NULL,
    [StoreNumber] INT           NULL,
    CONSTRAINT [PK_MSLxftSurfaceHubRetailDemoAppUsage_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);

