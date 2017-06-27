CREATE TABLE [dbo].[StoreSummaryDevice] (
    [store_device_id] INT  IDENTITY (1, 1) NOT NULL,
    [store_number]    INT  NULL,
    [modified_at]     DATE NOT NULL,
    [device_count]    INT  NOT NULL,
    PRIMARY KEY CLUSTERED ([store_device_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_StoreSummaryDevice_StoreNumber]
    ON [dbo].[StoreSummaryDevice]([store_number] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_StoreSummaryDevice_ModifiedAt]
    ON [dbo].[StoreSummaryDevice]([modified_at] ASC);

