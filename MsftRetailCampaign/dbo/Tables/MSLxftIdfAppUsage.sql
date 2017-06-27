CREATE TABLE [dbo].[MSLxftIdfAppUsage] (
    [ID]                    BIGINT        IDENTITY (1, 1) NOT NULL,
    [DateLoaded]            DATETIME      DEFAULT (getdate()) NULL,
    [EventTime]             DATETIME      NULL,
    [EventDate]             DATE          NULL,
    [EventName]             VARCHAR (100) NULL,
    [EventCount]            INT           NULL,
    [ExperienceName]        VARCHAR (200) NULL,
    [DeviceType]            VARCHAR (50)  NULL,
    [ClientIP]              VARCHAR (50)  NULL,
    [Continent]             VARCHAR (100) NULL,
    [Country]               VARCHAR (100) NULL,
    [Province]              VARCHAR (100) NULL,
    [City]                  VARCHAR (100) NULL,
    [CustomCity]            VARCHAR (100) NULL,
    [PageViewDuration]      VARCHAR (100) NULL,
    [PageViewDurationSecs]  INT           NULL,
    [VideoPlayDuration]     VARCHAR (100) NULL,
    [VideoPlayDurationSecs] INT           NULL,
    [StoreNumber]           INT           NULL,
    CONSTRAINT [PK_MSLxftIdfAppUsage_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);

