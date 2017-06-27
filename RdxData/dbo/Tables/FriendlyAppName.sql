CREATE TABLE [dbo].[FriendlyAppName] (
    [Id]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [AppName]      VARCHAR (50)  NULL,
    [AppTitle]     VARCHAR (50)  NULL,
    [PublisherId]  VARCHAR (50)  NULL,
    [FriendlyName] VARCHAR (300) NULL,
    [IsWatched]    BIT           NULL,
    CONSTRAINT [PK_FriendlyAppName_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

