CREATE TABLE [dbo].[ExperienceHealth] (
    [exp_health_id] INT            IDENTITY (1, 1) NOT NULL,
    [exp_id]        INT            NULL,
    [store_number]  INT            NULL,
    [modified_at]   DATETIME       NULL,
    [total_devices] INT            NULL,
    [total_points]  DECIMAL (5, 1) NULL,
    [health_state]  VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([exp_health_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ExperienceHealth_ModifiedAt]
    ON [dbo].[ExperienceHealth]([modified_at] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ExperienceHealth_StoreNumber]
    ON [dbo].[ExperienceHealth]([store_number] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ExperienceHealth_ExpID]
    ON [dbo].[ExperienceHealth]([exp_id] ASC);

