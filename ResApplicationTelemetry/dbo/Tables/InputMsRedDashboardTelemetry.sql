CREATE TABLE [dbo].[InputMsRedDashboardTelemetry] (
    [Id]                  INT              IDENTITY (1, 1) NOT NULL,
    [AsaSyTimeStamp]      DATETIME         NULL,
    [SqlSyTimeStamp]      DATETIME         DEFAULT (getdate()) NULL,
    [EventTime]           DATETIME         NULL,
    [EventDate]           DATE             NULL,
    [ViewName]            VARCHAR (50)     NULL,
    [ViewCount]           INT              NULL,
    [ViewUrl]             VARCHAR (1000)   NULL,
    [ViewUrlDataBase]     VARCHAR (100)    NULL,
    [ViewUrlDataHost]     VARCHAR (100)    NULL,
    [ViewUrlDataHashTag]  VARCHAR (100)    NULL,
    [ViewUrlDataProtocol] VARCHAR (100)    NULL,
    [DurationValue]       FLOAT (53)       NULL,
    [DurationCount]       FLOAT (53)       NULL,
    [InternalDataId]      UNIQUEIDENTIFIER NULL,
    [UserAnonId]          VARCHAR (50)     NULL,
    [SessionId]           VARCHAR (50)     NULL,
    [OperationId]         VARCHAR (50)     NULL,
    [ClientIp]            VARCHAR (50)     NULL,
    [Continent]           VARCHAR (50)     NULL,
    [Country]             VARCHAR (50)     NULL,
    [Province]            VARCHAR (50)     NULL,
    [City]                VARCHAR (50)     NULL,
    [StoreNumber]         INT              DEFAULT ((-1)) NULL,
    [Processed]           INT              DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE TRIGGER dbo.trgProcessIncomingMsRedTelemetry
ON dbo.InputMsRedDashboardTelemetry
AFTER INSERT
AS
    DECLARE	@return_value Int

    EXEC	@return_value = [dbo].[uspProcessIncomingMsRedTelemetry]