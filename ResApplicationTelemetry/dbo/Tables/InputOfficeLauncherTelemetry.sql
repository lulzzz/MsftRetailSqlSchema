CREATE TABLE [dbo].[InputOfficeLauncherTelemetry] (
    [Id]              INT              IDENTITY (1, 1) NOT NULL,
    [EventTime]       DATETIME         NULL,
    [EventDate]       DATE             NULL,
    [EventName]       VARCHAR (100)    NULL,
    [EventCount]      INT              NULL,
    [ViewName]        VARCHAR (50)     NULL,
    [ViewCount]       INT              NULL,
    [DurationValue]   FLOAT (53)       NULL,
    [DurationCount]   FLOAT (53)       NULL,
    [DeviceType]      VARCHAR (50)     NULL,
    [DeviceOSVersion] VARCHAR (50)     NULL,
    [DeviceNetwork]   VARCHAR (50)     NULL,
    [SessionId]       UNIQUEIDENTIFIER NULL,
    [ClientIp]        VARCHAR (50)     NULL,
    [Continent]       VARCHAR (50)     NULL,
    [Country]         VARCHAR (50)     NULL,
    [Province]        VARCHAR (50)     NULL,
    [City]            VARCHAR (50)     NULL,
    [StoreNumber]     INT              NULL,
    [Processed]       INT              DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE TRIGGER dbo.trgProcessIncomingOfficeLauncherTelemetry
ON dbo.InputOfficeLauncherTelemetry
AFTER INSERT
AS
    DECLARE	@return_value Int

    EXEC	@return_value = [dbo].[uspProcessIncomingOfficeLauncherTelemetry]