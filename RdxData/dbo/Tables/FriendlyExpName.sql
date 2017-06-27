CREATE TABLE [dbo].[FriendlyExpName] (
    [Id]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [RAC]     VARCHAR (50)  NOT NULL,
    [ExpName] VARCHAR (100) NULL,
    CONSTRAINT [PK_FriendlyExpName_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

