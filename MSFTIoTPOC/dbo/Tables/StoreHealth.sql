CREATE TABLE [dbo].[StoreHealth] (
    [store_health_id] INT            IDENTITY (1, 1) NOT NULL,
    [store_number]    INT            NULL,
    [modified_at]     DATETIME       NULL,
    [total_devices]   INT            NULL,
    [total_points]    DECIMAL (5, 1) NULL,
    [health_state]    VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([store_health_id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_StoreHealth_ModifiedAt]
    ON [dbo].[StoreHealth]([modified_at] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_StoreHealth_StoreNumber]
    ON [dbo].[StoreHealth]([store_number] ASC);

