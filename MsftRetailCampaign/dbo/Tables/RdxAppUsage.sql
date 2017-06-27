CREATE TABLE [dbo].[RdxAppUsage] (
    [ID]                     BIGINT           IDENTITY (1, 1) NOT NULL,
    [DateLoaded]             DATETIME         DEFAULT (getdate()) NULL,
    [DateAdded]              DATETIME         NULL,
    [EventDate]              DATE             NULL,
    [EventTime]              DATETIME         NULL,
    [DeviceID]               VARCHAR (50)     NULL,
    [AppID]                  VARCHAR (300)    NULL,
    [AppName]                VARCHAR (150)    NULL,
    [AppTitle]               VARCHAR (250)    NULL,
    [AppVersion]             VARCHAR (150)    NULL,
    [AppType]                VARCHAR (50)     NULL,
    [Category]               VARCHAR (150)    NULL,
    [UserActiveDurationS]    DECIMAL (10, 3)  NULL,
    [InteractivityDurationS] DECIMAL (10, 3)  NULL,
    [KeyboardInputSecCount]  INT              NULL,
    [MouseInputSecCount]     INT              NULL,
    [TouchInputSecCount]     INT              NULL,
    [PenInputSecCount]       INT              NULL,
    [LaunchCount]            INT              NULL,
    [SessionID]              UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_RdxAppUsage_Id] PRIMARY KEY CLUSTERED ([ID] ASC)
);

