CREATE TABLE [dbo].[ViveOculusExperienceReport] (
    [Id]            INT          IDENTITY (1, 1) NOT NULL,
    [CompletedDate] DATETIME     NULL,
    [StoreNumber]   INT          NULL,
    [EnvelopeID]    VARCHAR (50) NULL,
    [Experience]    VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

