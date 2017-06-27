CREATE TABLE [dbo].[StoreTypes] (
    [StoreTypeId] INT           IDENTITY (1, 1) NOT NULL,
    [Flag]        VARCHAR (2)   NOT NULL,
    [Code]        VARCHAR (10)  NOT NULL,
    [Name]        VARCHAR (250) NOT NULL,
    [Deleted]     INT           DEFAULT ((0)) NULL,
    CONSTRAINT [PK_StoreTypes_StoreTypeId] PRIMARY KEY CLUSTERED ([StoreTypeId] ASC)
);

