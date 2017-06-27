CREATE TABLE [dbo].[Markets] (
    [MarketId]       INT           IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (50) NOT NULL,
    [Latitude]       FLOAT (53)    NULL,
    [Longitude]      FLOAT (53)    NULL,
    [ScaleFactor]    INT           NULL,
    [MarketRegionId] INT           NULL,
    CONSTRAINT [PK_Markets] PRIMARY KEY CLUSTERED ([MarketId] ASC),
    CONSTRAINT [FK_Markets_MarketRegions_MarketRegionId] FOREIGN KEY ([MarketRegionId]) REFERENCES [dbo].[MarketRegions] ([MarketRegionId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Markets_MarketRegions_MarketRegionId]
    ON [dbo].[Markets]([MarketRegionId] ASC);

