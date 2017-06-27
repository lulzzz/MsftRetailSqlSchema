CREATE EXTERNAL TABLE [dbo].[Stores] (
    [StoreId] INT NOT NULL,
    [Name] NVARCHAR (250) NOT NULL,
    [CityId] INT NOT NULL,
    [MarketId] INT NOT NULL,
    [Number] INT NULL,
    [TypeFlag] NVARCHAR (1) NULL,
    [StoreTypeId] INT NULL,
    [CexAcronym] NVARCHAR (5) NULL,
    [RtgAcronym] NVARCHAR (5) NULL,
    [ServerName] NVARCHAR (50) NULL,
    [TimeZone] NVARCHAR (50) NULL,
    [Deleted] INT NULL,
    [Latitude] FLOAT (53) NULL,
    [Longitude] FLOAT (53) NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

