CREATE EXTERNAL TABLE [dbo].[Cities] (
    [CityId] INT NOT NULL,
    [RegionId] INT NOT NULL,
    [Name] NVARCHAR (255) NOT NULL,
    [Latitude] FLOAT (53) NOT NULL,
    [Longtitude] FLOAT (53) NOT NULL
)
    WITH (
    DATA_SOURCE = [RemoteGeoIP]
    );

