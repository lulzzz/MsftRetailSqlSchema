CREATE TABLE [dbo].[InputIdfTelemetry] (
    [Id]                    INT           IDENTITY (1, 1) NOT NULL,
    [EventTime]             DATETIME      NULL,
    [EventDate]             DATE          NULL,
    [EventName]             VARCHAR (100) NULL,
    [EventCount]            INT           NULL,
    [ExperienceName]        VARCHAR (200) NULL,
    [DeviceType]            VARCHAR (50)  NULL,
    [ClientIp]              VARCHAR (50)  NULL,
    [Continent]             VARCHAR (50)  NULL,
    [Country]               VARCHAR (50)  NULL,
    [Province]              VARCHAR (50)  NULL,
    [City]                  VARCHAR (100) NULL,
    [Latitude]              FLOAT (53)    NULL,
    [Longitude]             FLOAT (53)    NULL,
    [CustomCity]            VARCHAR (100) NULL,
    [PageViewDuration]      VARCHAR (100) NULL,
    [PageViewDurationSecs]  INT           NULL,
    [VideoPlayDuration]     VARCHAR (100) NULL,
    [VideoPlayDurationSecs] INT           NULL,
    [StoreNumber]           INT           NULL,
    [Processed]             INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_InputIdfTelemetry_Processed]
    ON [dbo].[InputIdfTelemetry]([Processed] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_InputIdfTelemetry_AggregatedSearch]
    ON [dbo].[InputIdfTelemetry]([EventDate] ASC, [StoreNumber] ASC, [ExperienceName] ASC, [EventName] ASC);


GO
CREATE TRIGGER dbo.trgProcessIncomingIdfTelemetry
ON [dbo].[InputIdfTelemetry]
AFTER INSERT
AS
    DECLARE	@return_value Int

    EXEC	@return_value = [dbo].[uspProcessIncomingIdfTelemetry]