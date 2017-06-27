CREATE TABLE [dbo].[Experience] (
    [id]           INT          IDENTITY (1, 1) NOT NULL,
    [display_name] VARCHAR (50) NULL,
    [deleted]      INT          NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

