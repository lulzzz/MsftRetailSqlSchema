CREATE EXTERNAL TABLE [dbo].[Markets] (
    [MarketId] INT NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    [Latitude] FLOAT (53) NULL,
    [Longitude] FLOAT (53) NULL,
    [ScaleFactor] INT NULL,
    [MarketRegionId] INT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

