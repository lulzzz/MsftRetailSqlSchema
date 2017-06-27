CREATE TABLE [dbo].[StoreSummaryExperience] (
    [store_exp_id]    INT          IDENTITY (1, 1) NOT NULL,
    [store_number]    INT          NULL,
    [modified_at]     DATE         NOT NULL,
    [experience_name] VARCHAR (50) NULL,
    [health_status]   VARCHAR (50) NULL,
    [store_exp_count] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([store_exp_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [nci_wi_StoreSummaryExperience_8347B8F3C81412EF9963C467591B3BCB]
    ON [dbo].[StoreSummaryExperience]([experience_name] ASC, [modified_at] ASC, [store_number] ASC)
    INCLUDE([store_exp_count], [store_exp_id]);


GO
CREATE NONCLUSTERED INDEX [IX_StoreSummaryExperience_StoreNumber]
    ON [dbo].[StoreSummaryExperience]([store_number] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_StoreSummaryExperience_ModifiedAt]
    ON [dbo].[StoreSummaryExperience]([modified_at] ASC);

