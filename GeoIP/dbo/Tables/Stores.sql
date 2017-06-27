CREATE TABLE [dbo].[Stores] (
    [StoreId]     INT            NOT NULL,
    [Name]        NVARCHAR (250) NOT NULL,
    [CityId]      INT            NOT NULL,
    [MarketId]    INT            NULL,
    [Number]      INT            NOT NULL,
    [TypeFlag]    NVARCHAR (1)   NULL,
    [StoreTypeId] INT            NULL,
    [CexAcronym]  NVARCHAR (5)   NULL,
    [RtgAcronym]  NVARCHAR (5)   NULL,
    [ServerName]  NVARCHAR (50)  NULL,
    [TimeZone]    NVARCHAR (50)  NULL,
    [Deleted]     INT            DEFAULT ((0)) NULL,
    [Latitude]    FLOAT (53)     NULL,
    [Longitude]   FLOAT (53)     NULL,
    CONSTRAINT [PK_StoresNEW] PRIMARY KEY CLUSTERED ([Number] ASC),
    CONSTRAINT [FK_Stores_Cities_CityId] FOREIGN KEY ([CityId]) REFERENCES [dbo].[Cities] ([CityId]),
    CONSTRAINT [FK_Stores_Markets_MarketId] FOREIGN KEY ([MarketId]) REFERENCES [dbo].[Markets] ([MarketId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Stores_Markets_MarketId]
    ON [dbo].[Stores]([MarketId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Stores_Cities_CityId]
    ON [dbo].[Stores]([CityId] ASC);

