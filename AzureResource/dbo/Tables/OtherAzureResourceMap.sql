CREATE TABLE [dbo].[OtherAzureResourceMap] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [UsageResourceUri] VARCHAR (200) NULL,
    [ResourceUri]      VARCHAR (200) NULL,
    [FriendlyName]     VARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

