CREATE TABLE [dbo].[ExperienceCorrelation] (
    [id]     INT          IDENTITY (1, 1) NOT NULL,
    [exp_id] INT          NOT NULL,
    [name]   VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_ExperienceCorrelation] FOREIGN KEY ([exp_id]) REFERENCES [dbo].[Experience] ([id])
);

