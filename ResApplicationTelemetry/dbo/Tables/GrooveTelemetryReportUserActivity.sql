CREATE TABLE [dbo].[GrooveTelemetryReportUserActivity] (
    [id]                  INT           IDENTITY (1, 1) NOT NULL,
    [created_at]          DATETIME      NULL,
    [modified_at]         DATETIME      NULL,
    [event_time]          DATETIME      NULL,
    [event_date]          DATE          NULL,
    [event_name]          VARCHAR (50)  NULL,
    [event_duration_mins] FLOAT (53)    NULL,
    [session_id]          VARCHAR (100) NULL,
    [store_number]        INT           NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_GrooveTelemetryReportUserActivity_AggregatedSearch]
    ON [dbo].[GrooveTelemetryReportUserActivity]([event_date] ASC, [event_name] ASC, [store_number] ASC);

