CREATE TABLE [dbo].[MSRedHealthAlert] (
    [ID]         INT           NOT NULL,
    [DateLoaded] DATETIME      DEFAULT (getdate()) NULL,
    [Name]       VARCHAR (100) NULL,
    CONSTRAINT [PK_MSRedHealthAlert_ID] PRIMARY KEY CLUSTERED ([ID] ASC)
);

