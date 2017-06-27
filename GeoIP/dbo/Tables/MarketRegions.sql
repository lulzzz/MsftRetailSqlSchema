CREATE TABLE [dbo].[MarketRegions] (
    [MarketRegionId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (50) NOT NULL,
    [Latitude]       FLOAT (53)    NULL,
    [Longitude]      FLOAT (53)    NULL,
    [ScaleFactor]    INT           NULL,
    CONSTRAINT [PK_MarketRegions] PRIMARY KEY CLUSTERED ([MarketRegionId] ASC)
);

