CREATE TABLE [dbo].[MapData] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [ExperienceName] NVARCHAR (255) NULL,
    [City]           NVARCHAR (255) NULL,
    [StoreName]      NVARCHAR (255) NULL,
    [StoreNumber]    INT            NULL,
    [EventDate]      DATE           NULL,
    [Views]          INT            NULL,
    [Latitude]       FLOAT (53)     NULL,
    [Longitude]      FLOAT (53)     NULL,
    [Country]        NVARCHAR (50)  NULL,
    [Region]         NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_MapData_StoreNumber]
    ON [dbo].[MapData]([StoreNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MapData_ExperienceName]
    ON [dbo].[MapData]([ExperienceName] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MapData_EventDate]
    ON [dbo].[MapData]([EventDate] ASC);

