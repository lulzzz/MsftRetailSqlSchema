CREATE TABLE [dbo].[RedDebug] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [created_at]   DATETIME       NULL,
    [message]      NVARCHAR (MAX) NULL,
    [computername] VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

