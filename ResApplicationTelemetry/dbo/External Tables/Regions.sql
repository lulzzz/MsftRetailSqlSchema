CREATE EXTERNAL TABLE [dbo].[Regions] (
    [RegionId] INT NOT NULL,
    [CountryId] INT NOT NULL,
    [Name] NVARCHAR (50) NOT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

