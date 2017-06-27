CREATE EXTERNAL TABLE [dbo].[MarketRegions] (
    [MarketRegionId] INT NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [Latitude] FLOAT (53) NULL,
    [Longitude] FLOAT (53) NULL,
    [ScaleFactor] INT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

