CREATE TABLE [dbo].[GrooveTelemetryReportUserEvent] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [created_at]   DATETIME      NULL,
    [modified_at]  DATETIME      NULL,
    [event_date]   DATE          NULL,
    [event_name]   VARCHAR (100) NULL,
    [event_count]  INT           NULL,
    [store_number] INT           NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_GrooveTelemetryReportUserEvent_AggregatedSearch]
    ON [dbo].[GrooveTelemetryReportUserEvent]([event_date] ASC, [event_name] ASC, [store_number] ASC);

