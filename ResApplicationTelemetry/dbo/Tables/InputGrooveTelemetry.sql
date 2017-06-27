CREATE TABLE [dbo].[InputGrooveTelemetry] (
    [id]               INT           IDENTITY (1, 1) NOT NULL,
    [event_time]       DATETIME      NULL,
    [event_name]       VARCHAR (100) NULL,
    [event_count]      INT           NULL,
    [view_name]        VARCHAR (50)  NULL,
    [view_count]       INT           NULL,
    [session_id]       VARCHAR (100) NULL,
    [position]         INT           NULL,
    [is_music_playing] VARCHAR (100) NULL,
    [duration_value]   FLOAT (53)    NULL,
    [duration_count]   FLOAT (53)    NULL,
    [device_type]      VARCHAR (50)  NULL,
    [client_ip]        VARCHAR (50)  NULL,
    [continent]        VARCHAR (50)  NULL,
    [country]          VARCHAR (50)  NULL,
    [province]         VARCHAR (50)  NULL,
    [city]             VARCHAR (50)  NULL,
    [store_number]     INT           NULL,
    [processed]        INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_InputGrooveTelemetry_StoreNumber]
    ON [dbo].[InputGrooveTelemetry]([store_number] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_InputGrooveTelemetry_ViewName]
    ON [dbo].[InputGrooveTelemetry]([view_name] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_InputGrooveTelemetry_EventName]
    ON [dbo].[InputGrooveTelemetry]([event_name] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_InputGrooveTelemetry_EventTime]
    ON [dbo].[InputGrooveTelemetry]([event_time] ASC);


GO
CREATE TRIGGER dbo.trgProcessIncomingGrooveTelemetry
ON dbo.InputGrooveTelemetry
AFTER INSERT
AS
    DECLARE	@return_value Int

    EXEC	@return_value = [dbo].[uspProcessIncomingGrooveTelemetry]