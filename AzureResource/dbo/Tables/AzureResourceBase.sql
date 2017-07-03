CREATE TABLE [dbo].[AzureResourceBase] (
    [Id]                INT           IDENTITY (1, 1) NOT NULL,
    [ModifiedAt]        DATETIME      NULL,
    [CreatedAt]         DATETIME      NULL,
    [ResourceCreated]   DATETIME      NULL,
    [ResourceId]        VARCHAR (500) NULL,
    [ResourceName]      VARCHAR (100) NULL,
    [ResourceType]      VARCHAR (300) NULL,
    [ResourceGroupName] VARCHAR (100) NULL,
    [Location]          VARCHAR (100) NULL,
    [SubscriptionId]    VARCHAR (100) NULL,
    [SubscriptionName]  VARCHAR (100) NULL,
    [Project]           VARCHAR (100) NULL,
    [SubProject]        VARCHAR (150) NULL,
    [Environment]       VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);



