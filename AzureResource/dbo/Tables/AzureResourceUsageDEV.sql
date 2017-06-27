CREATE TABLE [dbo].[AzureResourceUsageDEV] (
    [Id]               INT             IDENTITY (1, 1) NOT NULL,
    [ModifiedAt]       DATETIME        NULL,
    [CreatedAt]        DATETIME        NULL,
    [UsageStartTime]   DATETIME        NULL,
    [UsageEndTime]     DATETIME        NULL,
    [MeterId]          VARCHAR (200)   NULL,
    [MeterName]        VARCHAR (200)   NULL,
    [MeterCategory]    VARCHAR (200)   NULL,
    [MeterSubCategory] VARCHAR (200)   NULL,
    [MeterRegion]      VARCHAR (200)   NULL,
    [Unit]             VARCHAR (100)   NULL,
    [Quantity]         DECIMAL (15, 6) NULL,
    [Name]             VARCHAR (200)   NULL,
    [ResourceUri]      VARCHAR (500)   NULL,
    [Location]         VARCHAR (100)   NULL,
    [SubscriptionId]   VARCHAR (100)   NULL,
    [BillingDate]      DATE            NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

