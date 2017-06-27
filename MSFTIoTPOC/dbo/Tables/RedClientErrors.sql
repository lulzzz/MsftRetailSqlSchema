CREATE TABLE [dbo].[RedClientErrors] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [created_at]      DATETIME       NULL,
    [eventidentifier] VARCHAR (50)   NULL,
    [message]         NVARCHAR (MAX) NULL,
    [computername]    VARCHAR (50)   NULL,
    [recordnumber]    VARCHAR (50)   NULL,
    [timegenerated]   VARCHAR (50)   NULL,
    [timewritten]     VARCHAR (50)   NULL,
    [type]            VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

