CREATE TABLE [dbo].[MSRetailStore] (
    [Number]       INT           NOT NULL,
    [DateLoaded]   DATETIME      DEFAULT (getdate()) NULL,
    [Name]         VARCHAR (250) NULL,
    [Type]         VARCHAR (2)   NULL,
    [Acronym]      NVARCHAR (5)  NULL,
    [Latitude]     FLOAT (53)    NULL,
    [Longitude]    FLOAT (53)    NULL,
    [City]         VARCHAR (250) NULL,
    [Region]       VARCHAR (100) NULL,
    [Country]      VARCHAR (100) NULL,
    [Market]       VARCHAR (100) NULL,
    [MarketRegion] VARCHAR (100) NULL,
    CONSTRAINT [PK_MSRetailStore_Number] PRIMARY KEY CLUSTERED ([Number] ASC)
);

