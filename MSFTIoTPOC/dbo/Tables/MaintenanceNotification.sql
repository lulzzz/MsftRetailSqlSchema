CREATE TABLE [dbo].[MaintenanceNotification] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [message]    VARCHAR (100) NULL,
    [start_date] DATETIME      NULL,
    [end_date]   DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

