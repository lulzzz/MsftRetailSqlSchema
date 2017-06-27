CREATE EXTERNAL TABLE [dbo].[Countries] (
    [CountryId] INT NOT NULL,
    [Name] NVARCHAR (50) NOT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

