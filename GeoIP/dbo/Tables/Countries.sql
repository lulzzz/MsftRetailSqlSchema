CREATE TABLE [dbo].[Countries] (
    [CountryId] INT           NOT NULL,
    [Name]      NVARCHAR (50) NOT NULL,
    [Deleted]   INT           DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED ([CountryId] ASC)
);

