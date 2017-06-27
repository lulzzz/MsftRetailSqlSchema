CREATE EXTERNAL TABLE [dbo].[IpRanges] (
    [IpRangeId] UNIQUEIDENTIFIER NOT NULL,
    [StoreId] INT NOT NULL,
    [IpFrom] NVARCHAR (15) NOT NULL,
    [IpTo] NVARCHAR (15) NOT NULL,
    [NetworkId] NVARCHAR (15) NOT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

