CREATE EXTERNAL TABLE [dbo].[StoreTimeZones] (
    [Id] INT NOT NULL,
    [StoreNumber] INT NOT NULL,
    [TimeZone] NVARCHAR (50) NOT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

