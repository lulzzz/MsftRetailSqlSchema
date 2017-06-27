CREATE EXTERNAL TABLE [dbo].[StoreTypes] (
    [StoreTypeId] INT NOT NULL,
    [Flag] VARCHAR (2) NOT NULL,
    [Code] VARCHAR (10) NOT NULL,
    [Name] VARCHAR (250) NOT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

