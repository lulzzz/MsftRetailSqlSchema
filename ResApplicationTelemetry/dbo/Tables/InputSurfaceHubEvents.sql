CREATE TABLE [dbo].[InputSurfaceHubEvents] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [AsaSysTime]  DATETIME      NULL,
    [SqlSysTime]  DATETIME      DEFAULT (getdate()) NULL,
    [EventTime]   DATETIME      NULL,
    [EventDate]   DATE          NULL,
    [EventName]   VARCHAR (100) NULL,
    [EventCount]  INT           NULL,
    [DeviceType]  VARCHAR (50)  NULL,
    [SessionId]   VARCHAR (50)  NULL,
    [ClientIp]    VARCHAR (50)  NULL,
    [Continent]   VARCHAR (50)  NULL,
    [Country]     VARCHAR (50)  NULL,
    [Province]    VARCHAR (50)  NULL,
    [City]        VARCHAR (50)  NULL,
    [LocalIp]     VARCHAR (50)  NULL,
    [HubName]     VARCHAR (50)  NULL,
    [StoreNumber] INT           NULL,
    [Processed]   INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_InputSurfaceHubEvents_Processed]
    ON [dbo].[InputSurfaceHubEvents]([Processed] ASC);


GO
CREATE TRIGGER dbo.trgProcessIncomingSurfaceHubTelemetry
ON dbo.InputSurfaceHubEvents
AFTER INSERT
AS
    DECLARE	@return_value Int

    EXEC	@return_value = [dbo].[uspProcessIncomingSurfaceHubTelemetry]