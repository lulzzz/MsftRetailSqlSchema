CREATE TABLE [dbo].[MSRedHealthAlertResult] (
    [ID]            BIGINT       IDENTITY (1, 1) NOT NULL,
    [DateLoaded]    DATETIME     DEFAULT (getdate()) NULL,
    [HealthAlertID] INT          NULL,
    [DeviceID]      INT          NULL,
    [HealthState]   VARCHAR (50) NULL,
    [StoreNumber]   INT          NULL,
    [Result]        INT          NULL,
    [DatePassed]    DATETIME     NULL,
    [FirstRunDate]  DATETIME     NULL,
    [LastRunDate]   DATETIME     NULL,
    CONSTRAINT [PK_MSRedHealthAlertResult_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);

