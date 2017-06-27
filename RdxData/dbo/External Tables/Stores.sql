CREATE EXTERNAL TABLE [dbo].[Stores] (
    [StoreId] INT NOT NULL,
    [Name] NVARCHAR (250) NOT NULL,
    [CityId] INT NOT NULL,
    [MarketId] INT NOT NULL,
    [Number] INT NULL,
    [TypeFlag] NVARCHAR (1) NULL,
    [CexAcronym] NVARCHAR (5) NULL,
    [RtgAcronym] NVARCHAR (5) NULL,
    [ServerName] NVARCHAR (50) NULL,
    [TimeZone] NVARCHAR (50) NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

