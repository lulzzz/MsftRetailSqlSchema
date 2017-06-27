CREATE TABLE [dbo].[AzureRateCard] (
    [Id]               INT             IDENTITY (1, 1) NOT NULL,
    [ModifiedAt]       DATETIME        NULL,
    [CreatedAt]        DATETIME        NULL,
    [EffectiveDate]    DATETIME        NULL,
    [MeterId]          VARCHAR (200)   NULL,
    [MeterName]        VARCHAR (200)   NULL,
    [MeterCategory]    VARCHAR (200)   NULL,
    [MeterSubCategory] VARCHAR (200)   NULL,
    [MeterRegion]      VARCHAR (200)   NULL,
    [MeterRate0]       DECIMAL (15, 6) NULL,
    [MeterStatus]      VARCHAR (100)   NULL,
    [MeterTags]        VARCHAR (500)   NULL,
    [Unit]             VARCHAR (100)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

