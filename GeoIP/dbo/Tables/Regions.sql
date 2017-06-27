CREATE TABLE [dbo].[Regions] (
    [RegionId]  INT           NOT NULL,
    [CountryId] INT           NOT NULL,
    [Name]      NVARCHAR (50) NOT NULL,
    [Deleted]   INT           DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Regions] PRIMARY KEY CLUSTERED ([RegionId] ASC),
    CONSTRAINT [FK_Regions_Countries_CountryId] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Countries] ([CountryId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Regions_Countries_CountryId]
    ON [dbo].[Regions]([CountryId] ASC);

