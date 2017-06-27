CREATE TABLE [dbo].[MSLxftMusicExperienceAppUsage] (
    [ID]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [DateLoaded]       DATETIME      DEFAULT (getdate()) NULL,
    [EventTime]        DATETIME      NULL,
    [EventName]        VARCHAR (100) NULL,
    [EventCount]       INT           NULL,
    [ViewName]         VARCHAR (100) NULL,
    [ViewCount]        INT           NULL,
    [SessionID]        VARCHAR (150) NULL,
    [Position]         INT           NULL,
    [IsMusicPlaying]   VARCHAR (50)  NULL,
    [DurationValueMin] FLOAT (53)    NULL,
    [DurationCount]    INT           NULL,
    [DeviceType]       VARCHAR (50)  NULL,
    [ClientIP]         VARCHAR (50)  NULL,
    [Continent]        VARCHAR (100) NULL,
    [Country]          VARCHAR (100) NULL,
    [Province]         VARCHAR (100) NULL,
    [City]             VARCHAR (100) NULL,
    [StoreNumber]      INT           NULL,
    CONSTRAINT [PK_MSLxftMusicExperienceAppUsage_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);

