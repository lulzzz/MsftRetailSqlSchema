CREATE TABLE [dbo].[StoreTimeZones] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [StoreNumber] INT           NOT NULL,
    [TimeZone]    NVARCHAR (50) NOT NULL,
    CONSTRAINT [PK_StoreTimeZones_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

