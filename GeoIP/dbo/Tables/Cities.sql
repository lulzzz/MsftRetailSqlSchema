CREATE TABLE [dbo].[Cities] (
    [CityId]     INT            IDENTITY (1, 1) NOT NULL,
    [RegionId]   INT            NOT NULL,
    [Name]       NVARCHAR (255) NOT NULL,
    [Latitude]   FLOAT (53)     NOT NULL,
    [Longtitude] FLOAT (53)     NOT NULL,
    [Deleted]    INT            DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Cities_CityId] PRIMARY KEY CLUSTERED ([CityId] ASC),
    CONSTRAINT [FK_Citis_Regions_RegionId] FOREIGN KEY ([RegionId]) REFERENCES [dbo].[Regions] ([RegionId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Cities_Regions_RegionId]
    ON [dbo].[Cities]([RegionId] ASC);

